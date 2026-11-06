/* Supabase > Project Settings > API se ye do cheezein yahan paste karein:
   url = "Project URL"   key = "anon public" key
   (anon key public hoti hai, website mein rakhna theek hai. "service_role" key KABHI yahan na daalein.)
   Khaali rahe to website "demo mode" mein chalti hai: jawab WhatsApp se family ko jate hain. */
window.DAWAT_DB = {
  url: "",
  key: ""
};

/* Dono pages yahi helpers use karte hain */
window.dawatDB = (() => {
  const c = window.DAWAT_DB || {};
  if (!c.url || !c.key) return null;
  const base = c.url.replace(/\/+$/, "") + "/rest/v1";
  const headers = { apikey: c.key, Authorization: "Bearer " + c.key, "Content-Type": "application/json" };
  async function call(path, body, extra = {}) {
    const res = await fetch(base + path, { method: "POST", headers: { ...headers, ...extra }, body: JSON.stringify(body) });
    if (!res.ok) throw new Error((await res.text()) || res.status);
    return res.status === 204 ? null : res.json();
  }
  return {
    createEvent: (id, secret) => call("/rpc/create_event", { p_id: id, p_secret: secret }),
    addRsvp: row => call("/rsvps", row, { Prefer: "return=minimal" }),
    getRsvps: (id, secret) => call("/rpc/get_rsvps", { p_id: id, p_secret: secret })
  };
})();

/* Pakistani number ko WhatsApp format mein: 0300-1234567 -> 923001234567 */
window.waNumber = n => {
  let d = String(n || "").replace(/\D/g, "");
  if (d.startsWith("00")) d = d.slice(2);
  if (d.startsWith("0")) d = "92" + d.slice(1);
  return d.length >= 10 ? d : "";
};
