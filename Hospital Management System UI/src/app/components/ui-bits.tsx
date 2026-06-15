import React from "react";

export function Panel({
  title,
  actions,
  children,
  className = "",
}: {
  title?: string;
  actions?: React.ReactNode;
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <section className={`bg-white border border-slate-200 rounded ${className}`}>
      {(title || actions) && (
        <div className="px-4 py-3 border-b border-slate-200 flex items-center justify-between bg-slate-50">
          {title && <div className="text-[#0b2545]">{title}</div>}
          {actions}
        </div>
      )}
      <div className="p-4">{children}</div>
    </section>
  );
}

export function Field({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) {
  return (
    <label className="block">
      <span className="block text-sm text-slate-700 mb-1">{label}</span>
      {children}
    </label>
  );
}

const baseInput =
  "w-full border border-slate-300 rounded px-3 py-2 text-sm bg-white focus:outline-none focus:border-[#1ca39a] focus:ring-1 focus:ring-[#1ca39a]";

export function TextInput(props: React.InputHTMLAttributes<HTMLInputElement>) {
  return <input {...props} className={`${baseInput} ${props.className ?? ""}`} />;
}

export function TextArea(props: React.TextareaHTMLAttributes<HTMLTextAreaElement>) {
  return <textarea {...props} className={`${baseInput} ${props.className ?? ""}`} />;
}

export function Select(props: React.SelectHTMLAttributes<HTMLSelectElement>) {
  return <select {...props} className={`${baseInput} ${props.className ?? ""}`} />;
}

type BtnVariant = "primary" | "secondary" | "danger" | "teal";

export function Button({
  variant = "primary",
  className = "",
  ...rest
}: React.ButtonHTMLAttributes<HTMLButtonElement> & { variant?: BtnVariant }) {
  const styles: Record<BtnVariant, string> = {
    primary: "bg-[#0b2545] text-white hover:bg-[#13366b] border-[#0b2545]",
    teal: "bg-[#1ca39a] text-white hover:bg-[#178c84] border-[#1ca39a]",
    secondary: "bg-slate-100 text-slate-700 hover:bg-slate-200 border-slate-300",
    danger: "bg-[#b3261e] text-white hover:bg-[#922019] border-[#b3261e]",
  };
  return (
    <button
      {...rest}
      className={`inline-flex items-center gap-1.5 px-3 py-1.5 text-sm border rounded ${styles[variant]} ${className}`}
    />
  );
}

export function Table({
  columns,
  children,
}: {
  columns: string[];
  children: React.ReactNode;
}) {
  return (
    <div className="overflow-x-auto border border-slate-200 rounded">
      <table className="w-full text-sm">
        <thead className="bg-slate-100 text-slate-700">
          <tr>
            {columns.map((c) => (
              <th key={c} className="text-left px-3 py-2 border-b border-slate-200">
                {c}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>{children}</tbody>
      </table>
    </div>
  );
}

export function Td({
  children,
  className = "",
}: {
  children?: React.ReactNode;
  className?: string;
}) {
  return (
    <td className={`px-3 py-2 border-b border-slate-100 align-middle ${className}`}>
      {children}
    </td>
  );
}

export function StatusBadge({ status }: { status: string }) {
  const s = status.toLowerCase();
  const map: Record<string, string> = {
    paid: "bg-emerald-100 text-emerald-700 border-emerald-200",
    unpaid: "bg-red-100 text-red-700 border-red-200",
    confirmed: "bg-emerald-100 text-emerald-700 border-emerald-200",
    pending: "bg-amber-100 text-amber-700 border-amber-200",
    completed: "bg-sky-100 text-sky-700 border-sky-200",
    cancelled: "bg-slate-200 text-slate-600 border-slate-300",
    available: "bg-emerald-100 text-emerald-700 border-emerald-200",
    "on leave": "bg-amber-100 text-amber-700 border-amber-200",
  };
  const cls = map[s] ?? "bg-slate-100 text-slate-700 border-slate-200";
  return (
    <span className={`inline-block px-2 py-0.5 text-xs border rounded ${cls}`}>
      {status}
    </span>
  );
}
