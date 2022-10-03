    build {
      "type" = "azure-arm",
      "client_id" = "9799262d-6ef6-426c-bbec-1899f09d8207",
      "client_secret" = "l558Q~TQFkcReZ9AVAbmElS9Qzseenz25f_TnbcR",
      "subscription_id" = "f7e798a6-8fd2-4799-8302-cbffa03bb9a7",
      "managed_image_resource_group_name" = "myPackergroup",
      "managed_image_name" = "myPackerImagepro",
  
      "os_type" = "Windows",
      "image_publisher" = "MicrosoftWindowsDesktop",
      "image_offer" = "Windows-10",
      "image_sku" = "win10-21h2-pro",
      "image_version" = "latest",
      
      "communicator" = "winrm",
      "winrm_use_ssl" = true,
      "winrm_insecure" = true,
      "winrm_timeout" = "30m",
      "winrm_username" = "packer",
      "async_resourcegroup_delete" = true,
  
      "azure_tags": {
          "dept" = "ECAD",
          "task" = "Image deployment"
      },
  
      "location" = "westeurope",
      "vm_size" = "Standard_DS2_v2",
      "managed_image_storage_account_type" = "Standard_LRS"

    }

    provisioner "powershell"{
      inline = [
        "Add-WindowsFeature Web-Server",
        "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit",
        "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
      ]
    }
