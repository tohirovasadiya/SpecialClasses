$extractPath = "$env:TEMP\lab6"
$xmlPath = Join-Path $extractPath 'word\document.xml'
[xml]$doc = Get-Content $xmlPath
$ns = New-Object System.Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main')
$nodes = $doc.SelectNodes('//w:p', $ns)
foreach ($p in $nodes) {
    $text = ($p.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join ''
    if ($text -match '3-vazifa|4-vazifa|5-vazifa|6-vazifa|7-vazifa|8-vazifa') {
        Write-Output "--- PARAGRAPH ---"
        Write-Output $text
    }
}
