from flask import Flask, send_from_directory, abort, request
import json
import requests
import os
import label
import subprocess
app = Flask(__name__)

def pretty_print_POST(req):
    """
    At this point it is completely built and ready
    to be fired; it is "prepared".

    However pay attention at the formatting used in 
    this function because it is programmed to be pretty 
    printed and may differ from the actual request.
    """
    print('{}\n{}\r\n{}\r\n\r\n{}'.format(
        '-----------START-----------',
        req.method + ' ' + req.url,
        '\r\n'.join('{}: {}'.format(k, v) for k, v in req.headers.items()),
        req.body,
    ))

FILES_DIR = os.path.join(os.path.dirname(__file__), "files")
@app.route('/')
def index():
    return("↑ ↑ ↓ ↓ ← → ← → B A")

@app.route('/snipe_api')
def home():
    return "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODE4ZjZmNjE1ZGMwZDAxM2ZlMTNiYmJjNDJkNjQ2ZTExNTc2MGRhODEzMGZhMTkzYzU3MGE1YmQzNTI5NzMyYTRkOTgzOTlmODcxZDYzYjQiLCJpYXQiOjE3NTQzMjgyODMuOTcxMTQzLCJuYmYiOjE3NTQzMjgyODMuOTcxMTQ1LCJleHAiOjIzODU0ODAyODMuOTY1OTg1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.oHmtjfbIaLLdwrM3-8ANjNFsxm2lNXg6_4pB5E5wWykUR32f022aAzOUUHnoQ_TcJ6gDk1mbhfPMcMtW-tJ7qeba5sGoPxuNolw_2ZcA4bRZ-UGpRJnNdAqI6Q2vHTsyFqpMBD0HadH7zKinh9BkWjGg81wRrgWXhU0rCflRGbeOQlwskZX85Iw9cp0RIFAl2aAceSNs4KtVBKS5LtWcgbM0B9sTSZkCemdtX7dP95HiVc7QVE2sXZLMqeM5tjRq8-_SkvZicpinBBbWdV5iwz58BfyRvLe5ax6ApRV6y2xImw1x5_G_7y_L0zuNJMwvDukf4v0xX9jt0tWDL0wBSgZCpE4Ec1PUguB15Y1XMcWQQAUGgNxyi18wxWF4eRKMCLQshxzg5CiVrmFv_fgPawGWLZyOOJZWUrLO33zAs2hn01S3NMytTA2UD94w2vszVzVZ8n6lZtpm_DZU38UacY7v1s9S_I0hFWl-4KEsCVpVLPaC99cwrK-pPeJw4YHymLtvYa_On_34ROKd825KMlvA2VEah22PgnijNvS6itJ1U75W699a5NRqSaux30q7mUhLPwXbUvcJUuZNBslMtjqXVLtxBZAyRvG8WWtflSP7BAoMIuGEDPR-RpfAG_4NNLNWlgUS5yWH3lSL2DGh5L4gQEzu5GntaXSCiy5SFyU"

@app.route('/late_command.sh')
def download_late():
    try:
        return send_from_directory(FILES_DIR, "late_command.sh", as_attachment=True)
    except FileNotFoundError:
        abort(404, description="File not found")

@app.route('/preseed_late.sh')
def download_file():
    try:
        return send_from_directory(FILES_DIR, "preseed_late.sh", as_attachment=True)
    except FileNotFoundError:
        abort(404, description="File not found")

@app.route('/preseed.cfg')
def download_pre():
    try:
        return send_from_directory(FILES_DIR, "preseed.cfg", as_attachment=True)
    except FileNotFoundError:
        abort(404, description="File not found")


@app.route("/label-demo", methods=["POST"])
def build():
    typst_bytes = request.get_data()
    typst_string = typst_bytes.decode("utf-8")

    try:
        j = json.loads(typst_string)
    except json.JSONDecodeError as e:
        print(e)
        return "Failed"

    pdf = label.compile_pdf(j)
#    print(pdf)
#    with open("./temp.pdf","wb") as f:
#        f.write(pdf)

    subprocess.run(
            ["lpr", "-H", "10.200.4.12", "-P", "DYMO", "-o", "landscape", "-"], input=pdf
    )
    return "Success"

@app.route("/label", methods=["POST"])
def batch():
    typst_bytes = request.get_data()
    typst_string = typst_bytes.decode("utf-8")

    try:
        j = json.loads(typst_string)
    except json.JSONDecodeError as e:
        print(e)
        return "Failed"

    pdf = label.compile_pdf(j,batch=True)
#    print(pdf)
#    with open("./temp.pdf","wb") as f:
#        f.write(pdf)

    subprocess.run(
            ["lpr", "-H", "10.200.4.12", "-P", "DYMO", "-o", "landscape", "-"], input=pdf
    )
    return "Success"

if __name__ == '__main__':
    app.run(debug=True)
