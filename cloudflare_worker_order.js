/**
 * Cloudflare Worker — پروکسی سفارش فرنو یار
 * اپ ایرانی → این Worker → pythonanywhere (بدون فیلتر برای کاربر)
 *
 * Deploy:
 * 1) dash.cloudflare.com → Workers & Pages → Create Worker
 * 2) این کد را جایگزین کن → Save and Deploy
 * 3) آدرس workers.dev را در config.dart بگذار (orderProxyUrl)
 */

const PYTHONANYWHERE_ORDER =
  "https://nvdrmh.pythonanywhere.com/api/order";

export default {
  async fetch(request) {
    // CORS preflight
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,
        headers: corsHeaders(),
      });
    }

    if (request.method !== "POST") {
      return json({ ok: false, error: "POST only" }, 405);
    }

    try {
      const body = await request.text();
      const upstream = await fetch(PYTHONANYWHERE_ORDER, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body,
      });
      const text = await upstream.text();
      return new Response(text, {
        status: upstream.status,
        headers: {
          ...corsHeaders(),
          "Content-Type":
            upstream.headers.get("Content-Type") || "application/json",
        },
      });
    } catch (e) {
      return json({ ok: false, error: String(e) }, 502);
    }
  },
};

function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };
}

function json(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { ...corsHeaders(), "Content-Type": "application/json" },
  });
}
