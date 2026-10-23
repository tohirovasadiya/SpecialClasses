$src = 'C:\Users\oson pc\Downloads\Laboratory 6  Special Classes.docx'
$dest = "$env:TEMP\lab6.docx"
Copy-Item $src $dest -Force
Add-Type -AssemblyName System.IO.Compression.FileSystem
$extractPath = "$env:TEMP\lab6"
if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }
[IO.Compression.ZipFile]::ExtractToDirectory($dest, $extractPath)
$xmlPath = Join-Path $extractPath 'word\document.xml'
[xml]$doc = Get-Content $xmlPath
$ns = New-Object System.Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main')
$nodes = $doc.SelectNodes('//w:p', $ns)
foreach ($p in $nodes) {
    $text = ($p.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join ''
    if ($text) { Write-Output $text }
}
