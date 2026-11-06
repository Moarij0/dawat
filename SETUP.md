# Dawat: online ginti chalu karne ke qadam

## 1. Supabase (database), free
1. supabase.com par jayein → **Start your project** → Google se sign up karein
2. **New project** banayein (naam: `dawat`, region: **Singapore**, jo Pakistan ke qareeb hai), password kahin likh lein
3. Baayein taraf **SQL Editor** → **New query** → `setup.sql` ka poora text paste karein → **Run**
4. **Project Settings → API** kholein aur ye do cheezein copy karein:
   - **Project URL**
   - **anon public** key (⚠️ `service_role` wali key nahi)
5. Ye do cheezein Claude ko bhej dein, ya khud `config.js` mein `url` aur `key` ki jagah paste kar dein

## 2. Vercel (website live), free
1. vercel.com → Google/GitHub se sign up karein
2. **Add New → Project → Deploy without Git** → poora `wedding-invite` folder drag karein
3. Jo link mile (jaise `dawat.vercel.app`), wahi aap ki website hai

## Kaise kaam karta hai
- **Card banane wala page** (`index.html`) do link deta hai:
  - **Mehmaanon wala link:** WhatsApp par bhejne ke liye
  - **Family wala link** (`?host=…`): sirf apne paas rakhein
- **Mehmaan** naam aur kitne log bharta hai, to jawab database mein save hota hai. Ek WhatsApp button bhi milta hai jis se jawab family ko seedha bhi bheja ja sakta hai.
- **Family wala link** kholne par har taqreeb ki ginti (mard, khawateen, bachay) aur har mehmaan ka naam dikhta hai. Ye page har 20 second mein khud update hota hai.
- Supabase na laga ho to bhi website chalti hai: mehmaan ka jawab WhatsApp ke zariye family tak jata hai.
