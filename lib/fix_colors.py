import os

lib_dir = "d:/B2B/bara_2_babi/lib"

replacements = {
    "AppColors.neonBlue": "AppColors.primary",
    "AppColors.neonOrange": "AppColors.primary",
    "AppColors.neonPurple": "AppColors.primary",
    "AppColors.neonPink": "AppColors.primary",
    "AppColors.neonBlueDark": "AppColors.primaryDark",
    "AppColors.neonBlueGradient": "AppColors.primaryGradient",
    "AppColors.neonWarmGradient": "AppColors.primaryGradient",
    "AppColors.backgroundTertiary": "AppColors.backgroundSecondary",
    "AppColors.textOnNeon": "AppColors.textOnPrimary",
    "AppColors.glassBorder": "AppColors.borderColor",
    "AppColors.ivoryGreen": "AppColors.success",
    "AppColors.ivoryOrange": "AppColors.warning",
    "AppColors.ivoryWhite": "AppColors.backgroundPrimary",
    "AppColors.backgroundElevated": "AppColors.backgroundCard",
    "AppTheme.darkTheme": "AppTheme.lightTheme"
}

def replace_in_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = content
    for old, new in replacements.items():
        new_content = new_content.replace(old, new)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

for root, dirs, files in os.walk(lib_dir):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file))

print("Replacement complete.")
