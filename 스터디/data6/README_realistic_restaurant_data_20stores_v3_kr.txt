현실적인 음식점 20개 × 2025년 1년치 데이터 v3 생성 설명

이번 v3는 '결과 위험점수가 너무 단순하게 한 방향으로 수렴'하는 문제를 줄이기 위해
daily_cashflow를 더 강하게 시나리오 중심으로 재설계한 버전입니다.

핵심 변경점
1) 시나리오별 분기(Quarter) 목표 순현금흐름을 명시적으로 부여
   - 안정→위험: Q1/Q2 흑자, Q3/Q4 적자
   - 위험→안정: Q1 적자, 하반기 흑자
   - 위험 유지: 연중 적자
   - 안정 유지: 연중 흑자
   - U자형 / 역U자형 / 충격 후 회복 / 계절 악화 / 계절 회복 등 반영

2) 월 고정비를 일할 배분하여 너무 큰 월초/월말 왜곡을 줄임
3) daily expense는 '변동비 + 일할 고정비 + 일할 대출상환액' 구조
4) 이벤트/프로모션/비/연휴/요일 효과는 유지
5) opening_balance를 시나리오별로 차등 부여하여 위험 수준 다양화

목표
- 결과 csv에서 store별 위험 경로가 더 다양하게 나타나도록 함
- 예: 초반 안정→후반 위험 / 초반 위험→후반 안정 / 연중 위험 유지 / 중간 충격 후 회복

파일
- realistic_store_info_20_v3.csv
- realistic_store_profile_20_v3.csv
- realistic_loan_info_20_v3.csv
- realistic_fixed_cost_20_v3.csv
- realistic_daily_cashflow_20_v3.csv
- realistic_restaurant_dataset_20stores_v3.xlsx
