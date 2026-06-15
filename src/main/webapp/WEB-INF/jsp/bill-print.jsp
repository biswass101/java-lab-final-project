<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Bill ${bill.billCode}</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 24px; color: #1f2937; }
    .sheet { max-width: 900px; margin: 0 auto; border: 1px solid #d1d5db; border-radius: 10px; padding: 20px; }
    .head { display: flex; justify-content: space-between; border-bottom: 1px solid #e5e7eb; padding-bottom: 12px; margin-bottom: 14px; }
    .title { font-size: 22px; font-weight: 700; color: #0b2545; }
    .meta { font-size: 13px; color: #4b5563; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { border: 1px solid #e5e7eb; padding: 10px; text-align: left; }
    th { background: #f8fafc; }
    .total-row td { font-weight: 700; }
    .actions { margin: 16px 0; text-align: center; }
    .btn { background: #0b2545; color: #fff; border: 0; padding: 10px 14px; border-radius: 6px; cursor: pointer; }
    @media print { .actions { display: none; } body { margin: 0; } .sheet { border: 0; } }
  </style>
</head>
<body>
<div class="actions">
  <button class="btn" onclick="window.print()">Print Bill</button>
</div>
<div class="sheet">
  <div class="head">
    <div>
      <div class="title">City Hospital</div>
      <div class="meta">Dhaka, Bangladesh</div>
    </div>
    <div class="meta">
      <div><strong>Bill ID:</strong> ${bill.billCode}</div>
      <div><strong>Date:</strong> ${bill.billDate}</div>
      <div><strong>Status:</strong> ${bill.paymentStatus}</div>
    </div>
  </div>

  <div class="meta"><strong>Patient:</strong> ${bill.patientName}</div>

  <table>
    <thead>
      <tr><th>Item</th><th>Amount (TK)</th></tr>
    </thead>
    <tbody>
      <tr>
        <td>Consultation Fee</td>
        <td><fmt:formatNumber value="${bill.consultationFee}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
      </tr>
      <tr>
        <td>Medicine Cost</td>
        <td><fmt:formatNumber value="${bill.medicineCost}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
      </tr>
      <tr>
        <td>Service Charge</td>
        <td><fmt:formatNumber value="${bill.serviceCharge}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
      </tr>
      <tr class="total-row">
        <td>Total Amount</td>
        <td><fmt:formatNumber value="${bill.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
