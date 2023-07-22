using UnrealBuildTool;

public class JJ2Target : TargetRules
{
	public JJ2Target(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.V2;
		Type = TargetType.Game;
		ExtraModuleNames.Add("JJ2");
	}
}
