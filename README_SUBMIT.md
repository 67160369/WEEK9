# ส่งงานแลป OLTP / OLAP / Pivot (week09)

**ผู้จัดทำ:** นายวรพล พนานิธิมงคล · รหัสนิสิต 67160369 · กลุ่มเรียน 1

## ติดตั้งและรัน

```bash
pip install -r requirements.txt

# SQL ทีละข้อ
python query.py data/warehouse.db q01.sql        # ... ถึง q12.sql
python query.py data/extended.db  bonus_a1.sql
python query.py data/extended.db  bonus_a2.sql

# Python
python oltp_demo.py      # รัน 2 รอบ: รอบแรก rowcount=1 รอบสอง rowcount=0
python pivot_student.py
python challenge.py      # สร้าง data/challenge.db ใหม่ทุกครั้ง (ไม่แตะ warehouse.db)
```

## ไฟล์โค้ด
- `q01.sql` – `q12.sql` : คำตอบ SQL ทีละข้อ
- `bonus_a1.sql` : โจทย์ต่อยอด ก. 3 สาขายอดสูงสุด (extended.db)
- `bonus_a2.sql` : โจทย์ต่อยอด ก. AOV รายเดือน + AOV ทั้งช่วง (ถ่วงน้ำหนัก) + ค่าเฉลี่ย AOV รายเดือนแบบไม่ถ่วงน้ำหนัก
- `oltp_demo.py` : ภารกิจ 1 (guarded UPDATE)
- `pivot_student.py` : P1–P4 + ตัวอย่างบั๊ก mean + Pivot กรอง Drink
- `challenge.py` : โจทย์ต่อยอด ข. (สร้าง challenge.db เพิ่มข้อมูลตุลาคม แล้วตรวจก่อน–หลัง JOIN)

## ไฟล์ผลลัพธ์ (results/)
- `67160369_Lab_Report.docx` : รายงานคำตอบ พร้อมแผนภาพ Star Schema
- `star_schema.png` : แผนภาพ Star Schema
- `q01.out` – `q12.out`, `all_query_output.txt` : ผลรันแต่ละข้อ
- `oltp_run.txt` : ผลรัน oltp_demo.py สองรอบ
- `pivot_run.txt` : ผลรัน pivot_student.py ทั้งหมด (รวม assert)
- `pivot_province_month.csv` (P1), `pivot_september.csv` (P2), `pivot_drink.csv`
- `pivot_bug_mean.csv` (ก่อนแก้ ได้ 270) / `pivot_fixed_sum.csv` (หลังแก้ ได้ 540)
- `pivot.xlsx` : Pivot ทุกชุดในไฟล์ Excel
- `pivot_challenge.csv`, `challenge_run.txt`, `bonus_a.txt` : โจทย์ต่อยอด
- `foreign_key_check.txt`, `summary_stats.txt`

## ตัวเลขหลักที่ตรวจแล้ว
| รายการ | ค่า |
| --- | --- |
| บรรทัด / ออเดอร์ / ชิ้น / ยอดขาย | 8 / 6 / 23 / 1,390 บาท |
| AOV | 1,390 / 6 = 231.67 บาท |
| รายเดือน | 490 + 900 = 1,390 ✔ |
| รายวันกันยายน | 360 + 300 + 240 = 900 ✔ |
| ก่อน JOIN = หลัง JOIN | 8 / 6 / 1,390 ✔ |
| Pivot (margins) บวกทุกช่อง | 5,560 = 4 × 1,390 (นับซ้ำ ห้ามใช้) |
| challenge.db หลังเพิ่มตุลาคม | 11 / 8 / 1,900 (+510) ✔ |
| extended.db AOV ทั้งช่วง vs เฉลี่ยรายเดือน | 448.86 vs 449.05 |
