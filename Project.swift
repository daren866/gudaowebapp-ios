import ProjectDescription

let deploymentTargets: DeploymentTargets = .iOS("13.0")

let project = Project(
    name: "Gudaowebapp",
    organizationName: "Example",
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "<YOUR_DEVELOPMENT_TEAM_ID>",
            "CODE_SIGN_STYLE": "Automatic",
            "CODE_SIGN_IDENTITY": "Apple Development",
            "TARGETED_DEVICE_FAMILY": "1",
            "ENABLE_USER_SCRIPT_SANDBOXING": "NO"
        ],
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "Gudaowebapp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.gudao.webapp",
            deploymentTargets: deploymentTargets,
            infoPlist: .file(path: "Gudaowebapp/Info.plist"),
            sources: ["Gudaowebapp/**/*.swift"],
            resources: ["Gudaowebapp/Assets.xcassets", "Gudaowebapp/index.html"],
            dependencies: [
                .framework(name: "WebKit")
            ]
        )
    ]
)
