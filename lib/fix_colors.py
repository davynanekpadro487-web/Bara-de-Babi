import os

lib_dir = "d:/B2B/bara_2_babi/lib"

replacements = {
    "AppColors.neonBlueLight": "AppColors.neonPurple",
    "AppColors.neonBlueDark": "AppColors.neonBlueDark" # wait, did it become neonBlueDark? Yes, "AppColors.gold" became "AppColors.neonBlue" -> neonBlueDark
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
