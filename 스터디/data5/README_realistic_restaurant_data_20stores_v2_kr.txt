현실적인 음식점 20개 × 2025년 1년치 데이터 v2 생성 설명

1) 파일 구성
- realistic_store_info_20_v2.csv: 기본 점포 목록
- realistic_store_profile_20_v2.csv: 점포별 시나리오/변동성/초기조건
- realistic_loan_info_20_v2.csv: 점포별 대출 정보
- realistic_fixed_cost_20_v2.csv: 월별 고정비 상세
- realistic_daily_cashflow_20_v2.csv: 일별 현금흐름
- realistic_restaurant_dataset_20stores_v2.xlsx: 위 파일을 하나의 통합 엑셀로 정리
- summary 시트: 점포별 연간 요약

2) 이번 v2 데이터의 목표
- 위험점수가 연초/연말로 일방향 수렴하지 않도록 다양한 경로를 강하게 반영
- 예: 안정→위험, 위험→안정, 위험→위험, U자형, 역U자형, 충격 후 회복, 이벤트 변동형

3) 반영한 패턴
- stable_to_risk: 상반기 안정, 하반기 둔화 + 비용 압박
- risk_to_stable: 초반 부진, 판촉/회복으로 하반기 개선
- stable_to_stable: 연중 안정적 유지
- risk_to_risk: 연중 취약, 일부 충격 구간 포함
- u_shape / inverted_u: 연중 중간에 꺾이거나 반등하는 형태
- shock_and_recover: 특정 기간 급락 후 회복
- volatile_event / night_weekend / office_weekday: 업권별 패턴 반영
- 비, 연휴, 급여일, 스포츠 이벤트, 프로모션 반영
- 대출 상환은 특정 납부일에 월 상환액이 반영
- 월 고정비는 daily_cashflow의 other_expense에 여러 지급일로 분산 반영
  (rent/급여/보험/고정 유틸리티/고정 마케팅 일부 날짜 반영)

4) 참고
- 금액 단위는 원(KRW) 기준 synthetic data
- 날짜는 2025-01-01 ~ 2025-12-31
