import pandas as pd

df = pd.read_csv("MTA_Daily_Ridership_Data.csv")

count_columns = [col for col in df.columns if "Total" in col]
percent_columns = [col for col in df.columns if "%" in col]

df_count = df.melt(
    id_vars=["Date"], 
    value_vars=count_columns,
    var_name="Transport_Type",
    value_name="Total_Ridership"
)

df_percent = df.melt(
    id_vars=["Date"],
    value_vars=percent_columns,
    var_name="Transport_Type",
    value_name="Recovery_Percent"
)

df_count["Transport_Type"] = df_count["Transport_Type"].str.split(':').str[0]
df_percent["Transport_Type"] = df_percent["Transport_Type"].str.split(':').str[0]

df_unpivot = pd.merge(df_count, df_percent, on=["Date", "Transport_Type"])
# df_unpivot.to_csv("Output.csv", index = False)