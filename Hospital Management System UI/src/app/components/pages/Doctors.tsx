import { useState } from "react";
import { Button, Field, Panel, Select, StatusBadge, Table, Td, TextInput } from "../ui-bits";
import { Eye, Pencil, Trash2, Plus } from "lucide-react";

const seed = [
  { id: "D-101", name: "Dr. Farhana Akter", spec: "Cardiology", phone: "+880-1711-223344", availability: "Available" },
  { id: "D-102", name: "Dr. Mahbubur Rahman", spec: "Orthopedics", phone: "+880-1712-556677", availability: "Available" },
  { id: "D-103", name: "Dr. Nusrat Jahan", spec: "Pediatrics", phone: "+880-1713-889900", availability: "On Leave" },
  { id: "D-104", name: "Dr. Tanvir Ahmed", spec: "General Medicine", phone: "+880-1714-112233", availability: "Available" },
  { id: "D-105", name: "Dr. Sabina Yasmin", spec: "Dermatology", phone: "+880-1715-445566", availability: "Available" },
];

export function DoctorsPage() {
  const [query, setQuery] = useState("");
  const list = seed.filter((d) =>
    `${d.name} ${d.spec} ${d.id}`.toLowerCase().includes(query.toLowerCase()),
  );

  return (
    <div className="space-y-6">
      <Panel
        title="Doctor Management"
        actions={
          <div className="flex gap-2">
            <TextInput
              placeholder="Search doctor..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="w-64"
            />
            <Button variant="teal">
              <Plus className="w-4 h-4" /> Add Doctor
            </Button>
          </div>
        }
      >
        <Table columns={["Doctor ID", "Name", "Specialisation", "Phone", "Availability", "Action"]}>
          {list.map((d) => (
            <tr key={d.id} className="hover:bg-slate-50">
              <Td>{d.id}</Td>
              <Td>{d.name}</Td>
              <Td>{d.spec}</Td>
              <Td>{d.phone}</Td>
              <Td><StatusBadge status={d.availability} /></Td>
              <Td>
                <div className="flex gap-1.5">
                  <Button variant="secondary"><Eye className="w-3.5 h-3.5" /> View</Button>
                  <Button variant="primary"><Pencil className="w-3.5 h-3.5" /> Edit</Button>
                  <Button variant="danger"><Trash2 className="w-3.5 h-3.5" /> Delete</Button>
                </div>
              </Td>
            </tr>
          ))}
        </Table>
      </Panel>

      <Panel title="Add / Edit Doctor">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Doctor Name">
            <TextInput placeholder="Dr. Full Name" />
          </Field>
          <Field label="Specialisation">
            <Select defaultValue="">
              <option value="" disabled>Select specialisation</option>
              <option>Cardiology</option>
              <option>Orthopedics</option>
              <option>Pediatrics</option>
              <option>General Medicine</option>
              <option>Dermatology</option>
              <option>Neurology</option>
            </Select>
          </Field>
          <Field label="Phone Number">
            <TextInput placeholder="+880-1XXX-XXXXXX" />
          </Field>
          <Field label="Email">
            <TextInput type="email" placeholder="doctor@cityhospital.bd" />
          </Field>
          <Field label="Available Days">
            <TextInput placeholder="Sat, Sun, Mon, Wed" />
          </Field>
          <Field label="Consultation Fee (৳)">
            <TextInput type="number" placeholder="800" />
          </Field>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Submit</Button>
            <Button variant="secondary" type="reset">Reset</Button>
          </div>
        </form>
      </Panel>
    </div>
  );
}
