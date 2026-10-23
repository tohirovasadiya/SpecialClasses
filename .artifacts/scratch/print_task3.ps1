$extractPath = "$env:TEMP\lab6"
$xmlPath = Join-Path $extractPath 'word\document.xml'
[xml]$doc = Get-Content $xmlPath
$ns = New-Object System.Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main')
$nodes = $doc.SelectNodes('//w:p', $ns)
$recording = $false
foreach ($p in $nodes) {
    $text = ($p.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join ''
    if ($text -match '3-vazifa') { $recording = $true }
    if ($text -match '4-vazifa') { $recording = $false }
    if ($recording) { Write-Output $text }
}
