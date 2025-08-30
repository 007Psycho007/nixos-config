import typst
import json



def compile_pdf(data: dict, batch=False):
    data = {"computer": json.dumps(data)}
    if batch==True:
        temp = "files/batch.typ"
    else:
        temp = "files/main.typ"
    try:
        res = typst.compile(input=temp, sys_inputs=data)
    except RuntimeError as e:
        print(e)
        print("Error compiling")
        return False
    return(res)
