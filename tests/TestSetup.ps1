
$script:configFileName = 'dirtags.json'
$script:configFilePath = ('TestDrive:\' + $script:configFileName)
$script:tagVariables = @()
$script:missingConfigMessageCount = 0

function Setup-TestData() {

    $config = @'
{
  "dirTags": [
    {
      "name": "serverdocs",
      "path": "docs\\internal\\server"
    },
    {
      "name": "servercode",
      "path": "src\\server"
    }
  ],
  "workspaceTags": [
    {
        "name": "mainline",
        "path": "C:\\project1"
    },
    {
        "name": "devline",
        "path": "C:\\features\\project2"
    }
  ]
}
'@
    mkdir 'TestDrive:\project1'
    $config > 'TestDrive:\dirtags.json'
}