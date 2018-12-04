$script:MailHogVersion = "1.0.0"
$script:Revision = 0

@{
    Version = "$($script:MailHogVersion).$($script:Revision)"

    Image = @{
        Name = "origaminetwork/mailhog"

        Context = @{
            Path = "Image"
        }
        Arguments = @{
            MailHog = @{
                Version = $script:MailHogVersion
            }
        }
        Specification = @{
            Path = "Spec"
        }
    }

    Dependencies = @(
        @{ Name = 'Pester'; RequiredVersion = '4.3.1' }
    )

    Artifacts = @{
        Path = ".Artifacts"
    }
}
