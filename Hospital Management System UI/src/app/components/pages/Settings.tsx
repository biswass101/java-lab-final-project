import { Button, Field, Panel, Select, TextInput } from "../ui-bits";

export function SettingsPage() {
  return (
    <div className="space-y-6">
      <Panel title="Hospital Information">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Hospital Name">
            <TextInput defaultValue="City Hospital" />
          </Field>
          <Field label="Contact Number">
            <TextInput defaultValue="+880-2-9876543" />
          </Field>
          <Field label="Address">
            <TextInput defaultValue="House 12, Road 7, Dhanmondi, Dhaka 1209, Bangladesh" />
          </Field>
          <Field label="Email">
            <TextInput type="email" defaultValue="admin@cityhospital.bd" />
          </Field>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Save Changes</Button>
            <Button variant="secondary" type="reset">Cancel</Button>
          </div>
        </form>
      </Panel>

      <Panel title="Admin Account">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Username">
            <TextInput defaultValue="admin" />
          </Field>
          <Field label="Role">
            <Select defaultValue="Administrator">
              <option>Administrator</option>
              <option>Doctor</option>
              <option>Receptionist</option>
            </Select>
          </Field>
          <Field label="Current Password">
            <TextInput type="password" placeholder="••••••••" />
          </Field>
          <Field label="New Password">
            <TextInput type="password" placeholder="••••••••" />
          </Field>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Update Password</Button>
          </div>
        </form>
      </Panel>

      <Panel title="Database Connection (JDBC)">
        <div className="text-sm text-slate-600 space-y-1">
          <div>Driver: <code className="bg-slate-100 px-1 rounded">com.mysql.cj.jdbc.Driver</code></div>
          <div>URL: <code className="bg-slate-100 px-1 rounded">jdbc:mysql://localhost:3306/city_hospital_db</code></div>
          <div>Status: <span className="text-emerald-700">Connected</span></div>
        </div>
      </Panel>
    </div>
  );
}
