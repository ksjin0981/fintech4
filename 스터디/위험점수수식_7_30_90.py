# import pandas as pd
# from prophet import Prophet
# import matplotlib.pyplot as plt

# # 1. 파일 읽기 (업로드된 실제 파일명 반영)
# df = pd.read_csv('risk_prediction_result(2).csv')

# # 2. 특정 매장(예: S001) 데이터만 추출 (Prophet은 단일 시계열 필요)
# # 전체 매장을 합산하려면 df.groupby('date')['actual_end_balance'].sum() 등을 사용하세요.
# df_store = df[df['store_id'] == 'S003'].copy()

# # 3. Prophet 규격에 맞게 컬럼명 변경
# # date -> ds, actual_end_balance (또는 예측하고 싶은 값) -> y
# df_prophet = df_store[['date', 'closing_balance']].rename(columns={
#     'date': 'ds',
#     'closing_balance': 'y'
# })

# # 4. 모델 생성 및 학습
# m = Prophet()
# m.fit(df_prophet)

# # 5. 미래 데이터프레임 생성 (365일 예측)
# future = m.make_future_dataframe(periods=365)

# # 6. 예측 실행
# forecast = m.predict(future)

# # 7. 시각화
# fig1 = m.plot(forecast)
# plt.title('Store S001: Balance Forecast')
# plt.show()






import pandas as pd
import numpy as np

def calc_all_risk_scores(file_path):
    """
    7일(단기), 30일(월간), 90일(분기) 위험 점수 전부 계산
    """
    # 1. 데이터 로드
    df = pd.read_csv(file_path)
    df['date'] = pd.to_datetime(df['date'])
    df = df.sort_values(['store_id', 'date']).reset_index(drop=True)
    
    # 2. 지출 합산 (너의 컬럼 그대로)
    expense_cols = [
        'platform_fee', 'ingredient_cost', 'labor_cost', 
        'utilities_cost', 'marketing_cost', 'other_expense', 'loan_repayment'
    ]
    df['expense'] = df[expense_cols].sum(axis=1)
    
    # ========== 7일 단기 ==========
    df['exp_7d'] = df.groupby('store_id')['expense'].transform(lambda x: x.rolling(7, min_periods=3).mean())
    df['R_balance7'] = np.clip((df['exp_7d'] - df['closing_balance']) / np.maximum(df['exp_7d'], 1), 0, 1)
    
    df['sales_7d_avg'] = df.groupby('store_id')['total_sales'].transform(lambda x: x.rolling(7, min_periods=3).mean())
    df['R_accuracy7'] = np.clip(1 - (df['total_sales'] / np.maximum(df['sales_7d_avg'], 1)), 0, 1)
    
    df['balance_7d_mean'] = df.groupby('store_id')['closing_balance'].transform(lambda x: x.rolling(7, min_periods=3).mean())
    df['balance_14d_ago'] = df.groupby('store_id')['balance_7d_mean'].shift(7)
    trend7 = np.clip((df['balance_7d_mean'] - df['balance_14d_ago']) / np.maximum(df['balance_14d_ago'], 1), -1, 1)
    df['R_trend7'] = 0.5 * (-trend7 + 1)
    
    df['risk_score_7d'] = (0.4*df['R_balance7'] + 0.3*df['R_accuracy7'] + 0.3*df['R_trend7']) * 100
    
    # ========== 30일 월간 ==========
    df['exp_30d'] = df.groupby('store_id')['expense'].transform(lambda x: x.rolling(30, min_periods=5).mean())
    df['R_balance30'] = np.clip((df['exp_30d'] - df['closing_balance']) / np.maximum(df['exp_30d'], 1), 0, 1)
    
    df['sales_30d_avg'] = df.groupby('store_id')['total_sales'].transform(lambda x: x.rolling(30, min_periods=5).mean())
    df['R_accuracy30'] = np.clip(1 - (df['total_sales'] / np.maximum(df['sales_30d_avg'], 1)), 0, 1)
    
    df['balance_30d_mean'] = df.groupby('store_id')['closing_balance'].transform(lambda x: x.rolling(30, min_periods=5).mean())
    df['balance_60d_ago'] = df.groupby('store_id')['balance_30d_mean'].shift(30)
    trend30 = np.clip((df['balance_30d_mean'] - df['balance_60d_ago']) / np.maximum(df['balance_60d_ago'], 1), -1, 1)
    df['R_trend30'] = 0.5 * (-trend30 + 1)
    
    df['risk_score_30d'] = (0.4*df['R_balance30'] + 0.3*df['R_accuracy30'] + 0.3*df['R_trend30']) * 100
    
    # ========== 90일 분기 ==========
    df['exp_90d'] = df.groupby('store_id')['expense'].transform(lambda x: x.rolling(90, min_periods=10).mean())
    df['R_balance90'] = np.clip((df['exp_90d'] - df['closing_balance']) / np.maximum(df['exp_90d'], 1), 0, 1)
    
    df['sales_90d_avg'] = df.groupby('store_id')['total_sales'].transform(lambda x: x.rolling(90, min_periods=10).mean())
    df['R_accuracy90'] = np.clip(1 - (df['total_sales'] / np.maximum(df['sales_90d_avg'], 1)), 0, 1)
    
    df['balance_90d_mean'] = df.groupby('store_id')['closing_balance'].transform(lambda x: x.rolling(90, min_periods=10).mean())
    df['balance_180d_ago'] = df.groupby('store_id')['balance_90d_mean'].shift(90)
    trend90 = np.clip((df['balance_90d_mean'] - df['balance_180d_ago']) / np.maximum(df['balance_180d_ago'], 1), -1, 1)
    df['R_trend90'] = 0.5 * (-trend90 + 1)
    
    df['risk_score_90d'] = (0.4*df['R_balance90'] + 0.3*df['R_accuracy90'] + 0.3*df['R_trend90']) * 100
    
    # 결과 정리
    result_cols = [
        'store_id', 'date', 
        'risk_score_7d', 'risk_score_30d', 'risk_score_90d',
        'R_balance7', 'R_balance30', 'R_balance90'
    ]
    
    df_result = df[result_cols].round(1).fillna(0)
    return df_result

# 실행
pd.set_option('display.max_rows', None)
df_all = calc_all_risk_scores('daily_cashflow.csv')
print(df_all.groupby('store_id').tail(2))
