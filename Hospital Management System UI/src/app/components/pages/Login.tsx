import { useState } from "react";
import { Button, Field, TextInput } from "../ui-bits";
import { Hospital } from "lucide-react";

export function LoginPage({ onLogin }: { onLogin: () => void }) {
  const [u, setU] = useState("admin");
  const [p, setP] = useState("admin");

  return (
    <div className="min-h-screen bg-slate-100 flex items-center justify-center p-6">
      <div className="w-full max-w-md bg-white border border-slate-200 rounded shadow-sm">
        <div className="px-6 py-5 border-b border-slate-200 bg-[#0b2545] text-white rounded-t flex items-center gap-3">
          <Hospital className="w-7 h-7 text-[#1ca39a]" />
          <div>
            <div>City Hospital</div>
            <div className="text-xs text-slate-300">Management System — Admin Login</div>
          </div>
        </div>
        <form
          className="p-6 space-y-4"
          onSubmit={(e) => {
            e.preventDefault();
            onLogin();
          }}
        >
          <Field label="Username">
            <TextInput
              value={u}
              onChange={(e) => setU(e.target.value)}
              placeholder="Enter username"
              required
            />
          </Field>
          <Field label="Password">
            <TextInput
              type="password"
              value={p}
              onChange={(e) => setP(e.target.value)}
              placeholder="Enter password"
              required
            />
          </Field>
          <div className="flex items-center justify-between pt-2">
            <label className="flex items-center gap-2 text-sm text-slate-600">
              <input type="checkbox" /> Remember me
            </label>
            <a className="text-sm text-[#1ca39a] hover:underline" href="#">
              Forgot password?
            </a>
          </div>
          <Button type="submit" variant="primary" className="w-full justify-center py-2">
            Login
          </Button>
          <div className="text-center text-xs text-slate-500 pt-2 border-t border-slate-100">
            JSP + JDBC Based Web Application
            <div className="mt-1">© 2026 City Hospital, Dhaka, Bangladesh</div>
          </div>
        </form>
      </div>
    </div>
  );
}
