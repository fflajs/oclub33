// supabase/functions/gemini-proxy/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (req: Request) => {
  // --- Handle CORS preflight ---
  if (req.method === "OPTIONS") {
    return new Response("", {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
      },
    });
  }

  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    });
  }

  try {
    const { text } = await req.json();
    if (!text) throw new Error("Missing text input");

    const GEMINI_API_KEY = Deno.env.get("GEMINI_API_KEY");
    if (!GEMINI_API_KEY) throw new Error("Missing GEMINI_API_KEY in secrets");

    const url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=" +
      GEMINI_API_KEY;

    const body = {
      contents: [{ role: "user", parts: [{ text }] }],
    };

    const response = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });

    const data = await response.json();

    return new Response(JSON.stringify(data), {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});

