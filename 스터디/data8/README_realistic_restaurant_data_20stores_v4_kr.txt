현실적인 음식점 20개 × 2025년 1년치 데이터 v4 생성 설명

이번 v4의 목표
- 결과 위험등급이 '안정→위험' 같은 단순 2단계 경로가 아니라,
  1년 동안 여러 차례 오르내리는 서사가 나오도록 데이터 생성
- 예: 안정→위험→주의, 위험→안정→주의→위험→심각, 심각→위험→주의→안정 등

핵심 설계
1) 매장별 분기 목표 순현금흐름(Q1~Q4)을 다르게 부여
2) 월 단위로 추가 story adjustment를 넣어 같은 분기 안에서도 굴곡 발생
3) store별 충격구간 2개까지 부여
4) 이벤트/프로모션/비/연휴/요일효과 반영
5) 월 고정비는 일할 배분 + 특정일 추가 지출로 변동성 부여
6) opening balance, debt level, fixed cost 수준을 차등 설정

기대 효과
- 위험점수 결과가 연초/연말 단순 수렴형이 아니라
  store별로 여러 번 단계가 바뀌는 형태가 더 잘 나타남
- 다만 최종 위험등급은 사용자의 scoring formula에 의해 결정되므로,
  본 데이터는 그 formula가 다양하게 반응할 수 있도록 설계된 입력 데이터임

파일
- realistic_store_info_20_v4.csv
- realistic_store_profile_20_v4.csv
- realistic_loan_info_20_v4.csv
- realistic_fixed_cost_20_v4.csv
- realistic_daily_cashflow_20_v4.csv
- realistic_restaurant_dataset_20stores_v4.xlsx
