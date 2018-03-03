"""Module help work with REST service"""
import requests
from config import BASE_URL


class DemoREST(object):
    """Contains several methods work with REST service"""

    @staticmethod
    def call_basic_auth(base_name, base_password, check_name, check_password):
        """Get status_code from request after login attempt
        at url and with credentials specified in arguments"""

        url = '{}/basic-auth/{}/{}'.format(BASE_URL, base_name, base_password)
        request = requests.get(url, auth=(check_name, check_password))
        return request.status_code

    @staticmethod
    def call_get():
        """Get status_code and content from request"""

        url = '{}/get'.format(BASE_URL)
        request = requests.get(url)
        return request.status_code, request.content

    @staticmethod
    def call_steam(lines_number):
        """Get status_code and content from request with specified
        number of lines in arguments"""

        url = '{}/stream/{}'.format(BASE_URL, lines_number)
        request = requests.get(url)
        return request.status_code, request.content
