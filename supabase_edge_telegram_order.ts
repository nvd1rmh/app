// نام تابع: telegram-order
// در Supabase → Edge Functions بساز و این کد را بگذار
// JWT verification را برای این تابع خاموش کن (Verify JWT = OFF)

const PYTHONANYWHERE_ORDER = "https://nvdrmh.pythonanywhere.com/api/order";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization, apikey",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ ok: false, error: "POST only" }), {
      status: 405,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }
  try {
    const body = await req.text();
    const upstream = await fetch(PYTHONANYWHERE_ORDER, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body,
    });
    const text = await upstream.text();
    return new Response(text, {
      status: upstream.status,
      headers: {
        ...cors,
        "Content-Type": upstream.headers.get("Content-Type") || "application/json",
      },
    });
  } catch (e) {
    return new Response(JSON.stringify({ ok: false, error: String(e) }), {
      status: 502,
      headers: { ...cors, "Content-Type": "application/json" },
    });
  }
});
