#Sử dụng Google Big Query đễ xây dựng và chuẩn đoán

#Xây dựng modal với nhãn là cột Outcome
CREATE OR REPLACE MODEL `diabetes.logistic_reg_model`
OPTIONS
  (model_type='logistic_reg',
    input_label_cols=['Outcome']) AS
SELECT
  *
FROM
  `diabetes.data`
LIMIT 800 OFFSET 100

#Chaỵ với dữ liệu test
SELECT
  predicted_Outcome, raw.Outcome as real_OutCome
FROM
  ML.PREDICT(MODEL `graduationprojectms-75dd9.diabetes.logistic_reg_model`,
    (
    SELECT
      *
    FROM
      `diabetes.data`)),
      `diabetes.data` as raw
LIMIT 100

#Đánh giá mô hình
SELECT
  *
FROM
  ML.EVALUATE(MODEL `graduationprojectms75dd9.diabetes.logistic_reg_model`,
    (SELECT * FROM`diabetes.data` LIMIT 100))

#CONFUSION MATRIX
SELECT
  *
FROM
  ML.CONFUSION_MATRIX
(MODEL `graduationprojectms75dd9.diabetes.logistic_reg_model`,
    (SELECT * FROM`diabetes.data` LIMIT 100))
