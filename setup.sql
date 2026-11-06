-- Dawat: Supabase database setup
-- Supabase > SQL Editor > New query > ye poora paste karein > Run

-- 1) Har shaadi ka record (secret = family ka khufiya code)
create table if not exists events (
  id         text primary key check (char_length(id) between 8 and 32),
  secret     text not null check (char_length(secret) >= 16),
  created_at timestamptz not null default now()
);

-- 2) Mehmaanon ke jawab
create table if not exists rsvps (
  id         bigint generated always as identity primary key,
  event_id   text not null references events(id) on delete cascade,
  name       text not null check (char_length(name) between 1 and 60),
  events     text[] not null default '{}',
  decline    boolean not null default false,
  men        int not null default 0 check (men between 0 and 50),
  women      int not null default 0 check (women between 0 and 50),
  kids       int not null default 0 check (kids between 0 and 50),
  created_at timestamptz not null default now()
);
create index if not exists rsvps_event_idx on rsvps(event_id, created_at);

-- 3) Security: koi bhi seedha table nahi parh sakta
alter table events enable row level security;
alter table rsvps  enable row level security;

-- Mehmaan sirf jawab DAAL sakta hai (parh nahi sakta)
drop policy if exists "guests can reply" on rsvps;
create policy "guests can reply" on rsvps for insert to anon with check (true);

-- 4) Card banate waqt shaadi register karna
create or replace function create_event(p_id text, p_secret text)
returns void language sql security definer set search_path = public as $$
  insert into events(id, secret) values (p_id, p_secret) on conflict (id) do nothing;
$$;

-- 5) Family ka ginti page: sirf sahi secret ke saath jawab milte hain
create or replace function get_rsvps(p_id text, p_secret text)
returns setof rsvps language sql stable security definer set search_path = public as $$
  select r.* from rsvps r join events e on e.id = r.event_id
  where e.id = p_id and e.secret = p_secret
  order by r.created_at;
$$;

grant execute on function create_event(text, text) to anon;
grant execute on function get_rsvps(text, text) to anon;
