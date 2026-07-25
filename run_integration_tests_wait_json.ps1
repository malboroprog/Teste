# run_integration_tests_wait_json.ps1
 = "E:\teste\lua-5.5.0"
 = 8080
 = "voc"
 = "Paladin"
 = 30
 = 1

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

Set-Location 
if (Test-Path ".\.venv\Scripts\Activate.ps1") {
    . .\.venv\Scripts\Activate.ps1
} else {
    Write-Error "Activate.ps1 não encontrado em \.venv\Scripts. Verifique o venv."
    exit 1
}

 = "Set-Location ""; . .\.venv\Scripts\Activate.ps1; python .\mock_client\mock_client.py"
Start-Process powershell -ArgumentList '-NoExit','-Command',

 = Get-Date
 = .AddSeconds()
 = False
Write-Host "Aguardando http://127.0.0.1:/status responder com $() =  (timeout  s)..."

while ((Get-Date) -lt ) {
    try {
         = Invoke-WebRequest -Uri "http://127.0.0.1:/status" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
        if (.StatusCode -eq 200) {
            try {
                 = .Content | ConvertFrom-Json
                if ( -ne . -and (. -eq )) {
                    Write-Host "Endpoint /status respondeu com o JSON esperado."
                     = True
                    break
                } else {
                    Write-Host "Endpoint respondeu, mas $ExpectedKey não corresponde. Valor atual: "
                }
            } catch {
                Write-Host "Resposta recebida, mas não é JSON válido. Tentando novamente..."
            }
        }
    } catch {
    }
    Start-Sleep -Seconds 
}

if (-not ) {
    Write-Error "Timeout: o endpoint /status não respondeu com $ExpectedKey = $ExpectedValue em  segundos."
    Write-Host "Verifique a janela do mock para erros e tente novamente."
    exit 1
}

Write-Host "Executando testes de integração..."
python -m pytest tests/integration -q
 = 

if ( -eq 0) {
    Write-Host "Testes de integração concluídos com sucesso."
} else {
    Write-Host "Testes de integração falharam. Código de saída: "
}

exit 
