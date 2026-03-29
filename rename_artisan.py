import os
import re

dir_path = r'd:\B2B\bara_2_babi\lib'

for root, dirs, files in os.walk(dir_path):
    for file in files:
        if not file.endswith('.dart'):
            continue
        filepath = os.path.join(root, file)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        new = content

        # Protect code identifiers and role strings
        new = new.replace("'artisan'", "<<ROLE1>>")
        new = new.replace('"artisan"', "<<ROLE2>>")
        new = new.replace("artisanId", "<<AID>>")
        new = new.replace("artisanName", "<<ANAME>>")
        new = new.replace("artisanJob", "<<AJOB>>")
        new = new.replace("currentArtisan", "<<CURART>>")
        new = new.replace("artisanLocation", "<<ALOC>>")
        new = new.replace("selectedArtisan", "<<SELART>>")

        # French contractions
        new = new.replace("L'ARTISAN", "LE PRESTATAIRE")
        new = new.replace("l'artisan", "le prestataire")
        new = new.replace("L'artisan", "Le prestataire")
        new = new.replace("L'Artisan", "Le Prestataire")
        new = new.replace("D'ARTISANS", "DE PRESTATAIRES")
        new = new.replace("d'artisans", "de prestataires")
        new = new.replace("d'artisan", "de prestataire")
        new = new.replace("D'artisan", "De prestataire")

        # Regular words (order matters: plurals first)
        new = re.sub(r'\bARTISANS\b', 'PRESTATAIRES', new)
        new = re.sub(r'\bARTISAN\b', 'PRESTATAIRE', new)
        new = re.sub(r'\bArtisans\b', 'Prestataires', new)
        new = re.sub(r'\bArtisan\b', 'Prestataire', new)
        new = re.sub(r'\bartisans\b', 'prestataires', new)
        new = re.sub(r'\bartisan\b', 'prestataire', new)

        # Restore protected tokens
        new = new.replace("<<ROLE1>>", "'artisan'")
        new = new.replace("<<ROLE2>>", '"artisan"')
        new = new.replace("<<AID>>", "artisanId")
        new = new.replace("<<ANAME>>", "artisanName")
        new = new.replace("<<AJOB>>", "artisanJob")
        new = new.replace("<<CURART>>", "currentArtisan")
        new = new.replace("<<ALOC>>", "artisanLocation")
        new = new.replace("<<SELART>>", "selectedArtisan")

        if new != content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new)
            print(f'Updated: {file}')

print("Done!")
