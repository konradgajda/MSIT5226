# Createing the Data.txt file with the given table content
# The file will be created in the current working directory
# The content of the file will be as follows:

data_txt_content = """Tone\tFrequency\tHarmony\tParity
1\t2\t4\t3
3\t5\t6\t4
6\t4\t7\t2
9\t5\t8\t3
8\t12\t14\t5
6\t11\t4\t5
7\t4\t6\t3
13\t15\t10\t6
3\t5\t7\t6
6\t4\t9\t5
"""

data_txt_path = "./Data.txt"
with open(data_txt_path, "w") as file:
    file.write(data_txt_content)

data_txt_path