<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Prescription ${prescription.prescriptionCode}</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; color: #1f2937; }
    .sheet { max-width: 900px; margin: 0 auto; border: 1px solid #d1d5db; border-radius: 10px; padding: 20px; }
    .head { display: flex; justify-content: space-between; border-bottom: 1px solid #e5e7eb; padding-bottom: 12px; margin-bottom: 14px; }
    .title { font-size: 22px; font-weight: 700; color: #0b2545; }
    .meta { font-size: 13px; color: #4b5563; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { border: 1px solid #e5e7eb; padding: 10px; text-align: left; }
    th { background: #f8fafc; }
    .section { margin-top: 14px; }
    .actions { margin: 16px 0; text-align: center; }
    .btn { background: #0b2545; color: #fff; border: 0; padding: 10px 14px; border-radius: 6px; cursor: pointer; }
    @media print { .actions { display: none; } body { margin: 0; } .sheet { border: 0; } }
  </style>
</head>
<body>
<div class="actions">
  <button class="btn" onclick="window.print()">Print Prescription</button>
</div>
<div class="sheet">
  <div class="head">
    <div>
      <div class="title">City Hospital</div>
      <div class="meta">Dhaka, Bangladesh</div>
    </div>
    <div class="meta">
      <div><strong>Prescription ID:</strong> ${prescription.prescriptionCode}</div>
      <div><strong>Date:</strong> ${prescription.prescriptionDate}</div>
    </div>
  </div>

  <div class="meta"><strong>Patient:</strong> ${prescription.patientName}</div>
  <div class="meta"><strong>Doctor:</strong> ${prescription.doctorName}</div>
  <div class="section"><strong>Diagnosis:</strong> ${prescription.diagnosis}</div>

  <div class="section">
    <strong>Medicines & Dosage</strong>
    <table>
      <thead><tr><th>#</th><th>Medicine</th><th>Dosage</th></tr></thead>
      <tbody>
      <c:forEach items="${prescription.items}" var="m" varStatus="s">
        <tr>
          <td>${s.index + 1}</td>
          <td>${m.medicineName}</td>
          <td>${m.dosage}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="section"><strong>Instructions:</strong> ${prescription.instructions}</div>
</div>
</body>
</html>
