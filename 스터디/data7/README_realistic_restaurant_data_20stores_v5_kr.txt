현실적인 음식점 20개 × 2025년 1년치 데이터 v5 생성 설명

이번 v5의 목표
- risk_level이 너무 길게 같은 값으로 이어지지 않도록
- rolling 기반 위험공식에서도 일별로 더 자주 반응하도록
- '데이터부족→위험→심각' 같은 단순 패턴보다, 일별 등급 변동이 자주 나오도록 설계

v5 핵심 변경점
1) opening balance를 낮춰서 expense / balance 임계값 근처를 더 자주 넘나들게 함
2) noise_sigma 확대
3) 7일/13일 주기 단기 진동 추가
4) micro-positive / micro-negative shock 날짜 다수 추가
5) 비용 측 random hiccup(판촉비, 인건비, 기타비용 급증) 강화
6) month_target 보정 강도를 줄여 결과가 너무 매끈해지지 않도록 조정

주의
- 사용자의 risk formula 자체가 rolling average 기반이라,
  1일 단위로 완전히 랜덤하게 바뀌는 대신 '짧은 구간 진동' 형태가 주로 나타남.
- 그래도 v4보다 risk level 전환이 훨씬 자주 발생하도록 입력 데이터 측을 강화한 버전임.
