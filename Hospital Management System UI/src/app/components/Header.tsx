import { UserCircle2 } from "lucide-react";

interface Props {
  title: string;
}

export function Header({ title }: Props) {
  return (
    <header className="bg-white border-b border-slate-200 px-6 py-3 flex items-center justify-between">
      <div>
        <div className="text-[#0b2545]">{title}</div>
        <div className="text-xs text-slate-500">City Hospital — Management System</div>
      </div>
      <div className="flex items-center gap-3 text-sm text-slate-600">
        <span>Welcome, Admin</span>
        <UserCircle2 className="w-7 h-7 text-[#1ca39a]" />
      </div>
    </header>
  );
}
