@{
    PSDependOptions   = @{
        Target    = '$DependencyFolder'
        AddToPath = $True
    }
    PSScriptAnalyzer  = @{
        version = '1.20.0'
        source  = 'PSGalleryModule'
    }
    Assert            = @{
        version = '0.9.5'
        source  = 'PSGalleryModule'
    }
    PlatyPS           = @{
        version = '0.14.2'
        source  = 'PSGalleryModule'
    }
    'Powershell-YAML' = @{
        version = '0.4.2'
        source  = 'PSGalleryModule'
    }
    PSCodeHealth      = @{
        version = '0.2.26'
        source  = 'PSGalleryModule'
    }
    ModuleBuildTools  = @{
        version = '0.0.1'
        source  = 'PSGalleryModule'
    }
}