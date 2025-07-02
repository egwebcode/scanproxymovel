import requests
import json


dominio = input("Digite o domínio: ")


url = f'https://api.securitytrails.com/v1/domain/{dominio}/subdomains?children_only=false&include_inactive=true'
headers = {
    'APIKEY': 'IS-77CmNV6PzjiDd8hADeEPF6pbUfqU6',
    'accept': 'application/json'
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    data = response.json()
    
    if 'subdomains' in data:
        subdomains = data['subdomains']
        
        
        with open('subdominios.txt', 'w') as file:
            for subdomain in subdomains:
                print(f'{subdomain}.{dominio}')
                file.write(f'{subdomain}.{dominio}\n')
        
        print(f"Subdomínios salvos em subdominios.txt com sucesso para o domínio {dominio}!")
    else:
        print("Não foram encontrados subdomínios na resposta.")
else:
    print(f"Erro ao realizar a requisição: {response.status_code}")
