import requests
from pyquery import PyQuery
from urllib.parse import urljoin
from urllib.parse import urljoin, urlparse
import re

base_url = 'https://polygonscan.com'
url = 'https://polygonscan.com/txs'
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36',
    'Referer': 'https://polygonscan.com/',
    'Accept-Language': 'en-US,en;q=0.9',
}
response = requests.get(url, headers=headers)
if response.status_code == 200:
    html = response.text
    pq = PyQuery(html)
    tr_elements = pq('table tr:not(:first-child)')
    fee_values = []
    for tr in tr_elements:
        td = PyQuery(tr)('td:nth-child(2)')
        a = td('a')
        href = a.attr('href')
        full_url = urljoin(base_url, href)
        response = requests.get(full_url, headers=headers)
        if response.status_code == 200:
            html_content = response.text
            pq_content = PyQuery(html_content)
            span_tx_fee = pq_content('#ContentPlaceHolder1_spanTxFee').text()
            last_fragment = urlparse(full_url).path.split('/')[-1]
            # span_gas_price = pq_content('#ContentPlaceHolder1_spanGasPrice').text()
            # print(f"{last_fragment}: {span_gas_price}")
            print(f"{last_fragment}: {span_tx_fee}")
            # fee_value = re.search(r'\$([\d.]+)', span_tx_fee)
            fee_value = re.search(r'(\d+\.\d+)', span_tx_fee)
            if fee_value:
                fee_values.append(float(fee_value.group(1)))
        else:
            print(f'Failed to retrieve the content from {full_url}')                
    if fee_values:
        min_fee = min(fee_values)
        max_fee = max(fee_values)
        avg_fee = sum(fee_values) / len(fee_values)
        print(f"Minimum Fee: MATIC {min_fee:.4f}")
        print(f"Maximum Fee: MATIC {max_fee:.4f}")
        print(f"Average Fee: MATIC {avg_fee:.4f}")
    else:
        print("No fee values found")            
else:
    print('Failed to retrieve the web page')

