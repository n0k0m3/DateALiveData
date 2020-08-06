PackageManager = {}

PackageManager.packageList = {}

function PackageManager:init(url)
    if TFPackageManager then
        self.pm = TFPackageManager:GetInstance()
        self.pm:SetPackageDirUrl(url)
        local packageList = {}

        -- Not to use this for small package
        
        -- local count = self.pm:GetPackageDownloadCount()
        -- for i = 1, count do
        --     packageList[i] = {}
        --     packageList[i].name = self.pm:GetPackageName(i)
        --     packageList[i].downloadedSize = self.pm:GetPackageDownloadedSize(i)
        --     packageList[i].totalSize = self.pm:GetPackageTotalSize(i)
        --     packageList[i].state = self.pm:GetPackageDownloadState(i)
        -- end

        self.packageList = packageList
    end
end

function PackageManager:DownloadPackage(name, callback)
    -- for i = 1, table.getn(self.packageList) do
    --     if self.packageList[i].name == name then
    --         if not (self.packageList[i].state == 1 or self.packageList[i].state ==2) then
    --             self.pm:DownloadPackage(i, callback)
    --         end
    --         break;
    --     end
    -- end
end

function PackageManager:PauseDownload(index)
    -- TFPackageManager:GetInstance():StopPackageDownload(index)
end

return  PackageManager