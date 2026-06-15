import { useState } from "react";
import { Button, Field, Panel, Select, Table, Td, TextArea, TextInput } from "../ui-bits";
import { Eye, Pencil, Trash2, Plus } from "lucide-react";

const seed = [
  { id: "P-2001", name: "Rakibul Hasan", age: 45, gender: "Male", phone: "+880-1811-234567", blood: "B+" },
  { id: "P-2002", name: "Sumaiya Akter", age: 32, gender: "Female", phone: "+880-1812-345678", blood: "O+" },
  { id: "P-2003", name: "Mizanur Rahman", age: 60, gender: "Male", phone: "+880-1813-456789", blood: "A-" },
  { id: "P-2004", name: "Ayesha Siddika", age: 28, gender: "Female", phone: "+880-1814-567890", blood: "AB+" },
  { id: "P-2005", name: "Imran Hossain", age: 51, gender: "Male", phone: "+880-1815-678901", blood: "O-" },
  { id: "P-2006", name: "Tahmina Begum", age: 19, gender: "Female", phone: "+880-1816-789012", blood: "B-" },
];

export function PatientsPage() {
  const [query, setQuery] = useState("");
  const list = seed.filter((p) =>
    `${p.name} ${p.id} ${p.phone}`.toLowerCase().includes(query.toLowerCase()),
  );

  return (
    <div className="space-y-6">
      <Panel
        title="Patient Management"
        actions={
          <div className="flex gap-2">
            <TextInput
              placeholder="Search patient..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="w-64"
            />
            <Button variant="teal"><Plus className="w-4 h-4" /> Add Patient</Button>
          </div>
        }
      >
        <Table columns={["Patient ID", "Name", "Age", "Gender", "Phone", "Blood Group", "Action"]}>
          {list.map((p) => (
            <tr key={p.id} className="hover:bg-slate-50">
              <Td>{p.id}</Td>
              <Td>{p.name}</Td>
              <Td>{p.age}</Td>
              <Td>{p.gender}</Td>
              <Td>{p.phone}</Td>
              <Td>{p.blood}</Td>
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

      <Panel title="Add / Edit Patient">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Patient Name">
            <TextInput placeholder="Full name" />
          </Field>
          <Field label="Age">
            <TextInput type="number" placeholder="Age in years" />
          </Field>
          <Field label="Gender">
            <Select defaultValue="">
              <option value="" disabled>Select gender</option>
              <option>Male</option>
              <option>Female</option>
              <option>Other</option>
            </Select>
          </Field>
          <Field label="Phone">
            <TextInput placeholder="+880-1XXX-XXXXXX" />
          </Field>
          <Field label="Blood Group">
            <Select defaultValue="">
              <option value="" disabled>Select blood group</option>
              {["A+","A-","B+","B-","O+","O-","AB+","AB-"].map((b) => <option key={b}>{b}</option>)}
            </Select>
          </Field>
          <Field label="Email">
            <TextInput type="email" placeholder="patient@example.bd" />
          </Field>
          <div className="md:col-span-2">
            <Field label="Address">
              <TextArea rows={2} placeholder="House, Road, Thana, District, Postcode" />
            </Field>
          </div>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Submit</Button>
            <Button variant="secondary" type="reset">Reset</Button>
          </div>
        </form>
      </Panel>
    </div>
  );
}
