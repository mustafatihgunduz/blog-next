# Script: init-specific-repos.ps1

$basePath = "C:\Users\Gaming\Desktop\repo\TurkcellFrontend2025\Ogrenciler\EceIremKilic"  # EceIremKilic klasörü
$githubUsername = "mustafatihgunduz"  # GitHub kullanıcı adı
$targetProjects = @("blog-next", "react-blog")  # Çekmek istediğimiz projeler

foreach ($projectName in $targetProjects) {
    $projectPath = Join-Path $basePath $projectName

    Write-Host "⏳ EceIremKilic / $projectName için repo başlatılıyor..."

    Set-Location $projectPath

    # 1. Eski .git'i temizle (varsa)
    if (Test-Path ".git") {
        Remove-Item -Recurse -Force .git
        Write-Host "Eski git repoları temizlendi."
    }

    # 2. Yeni git repo başlat
    git init
    git add .
    git commit -m "Initial commit"

    # 3. Remote URL'yi ayarla (repo ismi dinamik)
    git remote remove origin
    git remote add origin "https://github.com/$githubUsername/$projectName.git"

    # 4. GitHub'daki repo ile merge işlemi (varsa)
    try {
        git pull origin master --allow-unrelated-histories
    }
    catch {
        Write-Host "GitHub'dan çekme işlemi başarısız oldu. Bu proje daha önce bir commit yapılmış olabilir."
    }

    # 5. GitHub'a push et
    git push -u origin master

    Write-Host "✅ EceIremKilic / $projectName GitHub’a gönderildi.`n"
}
