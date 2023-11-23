import azure.functions as func
import logging
import requests

app = func.FunctionApp()
FUNC_URL = "https://static-web-auth-function.azurewebsites.net/api/http_trigger"

@app.route(route="http_trigger", auth_level=func.AuthLevel.ANONYMOUS)
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Enable to see request structure
    # logging.info(req.get_json())

    response = requests.post(FUNC_URL, json = req.get_json())

    return response.text