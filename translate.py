import re

file_path = 'docs/translations.js'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

translations = {
    'fr': {'collaborators': 'Collaborateurs', 'collaboratorsSubtitle': 'Rencontrez notre équipe et nos contributeurs.', 'graphicDesigner': 'Graphiste'},
    'en': {'collaborators': 'Collaborators', 'collaboratorsSubtitle': 'Meet our team and contributors.', 'graphicDesigner': 'Graphic Designer'},
    'es': {'collaborators': 'Colaboradores', 'collaboratorsSubtitle': 'Conoce a nuestro equipo y colaboradores.', 'graphicDesigner': 'Diseñador Gráfico'},
    'de': {'collaborators': 'Mitarbeiter', 'collaboratorsSubtitle': 'Lernen Sie unser Team und unsere Mitwirkenden kennen.', 'graphicDesigner': 'Grafikdesigner'},
    'zh': {'collaborators': '合作者', 'collaboratorsSubtitle': '认识我们的团队和贡献者。', 'graphicDesigner': '平面设计师'},
    'ja': {'collaborators': 'コラボレーター', 'collaboratorsSubtitle': '私たちのチームと貢献者に会いましょう。', 'graphicDesigner': 'グラフィックデザイナー'},
    'ko': {'collaborators': '공동 작업자', 'collaboratorsSubtitle': '우리 팀과 기여자들을 만나보세요.', 'graphicDesigner': '그래픽 디자이너'},
    'it': {'collaborators': 'Collaboratori', 'collaboratorsSubtitle': 'Incontra il nostro team e i collaboratori.', 'graphicDesigner': 'Grafico'},
    'pt': {'collaborators': 'Colaboradores', 'collaboratorsSubtitle': 'Conheça nossa equipe e colaboradores.', 'graphicDesigner': 'Designer Gráfico'},
    'ru': {'collaborators': 'Сотрудники', 'collaboratorsSubtitle': 'Познакомьтесь с нашей командой и участниками.', 'graphicDesigner': 'Графический дизайнер'},
    'ar': {'collaborators': 'المتعاونون', 'collaboratorsSubtitle': 'تعرف على فريقنا والمساهمين.', 'graphicDesigner': 'مصمم جرافيك'},
    'hi': {'collaborators': 'सहयोगी', 'collaboratorsSubtitle': 'हमारी टीम और योगदानकर्ताओं से मिलें।', 'graphicDesigner': 'ग्राफिक डिज़ाइनर'},
    'tr': {'collaborators': 'Çalışanlar', 'collaboratorsSubtitle': 'Ekibimiz ve katkıda bulunanlarla tanışın.', 'graphicDesigner': 'Grafik Tasarımcı'},
    'nl': {'collaborators': 'Medewerkers', 'collaboratorsSubtitle': 'Ontmoet ons team en onze medewerkers.', 'graphicDesigner': 'Grafisch Ontwerper'},
    'pl': {'collaborators': 'Współpracownicy', 'collaboratorsSubtitle': 'Poznaj nasz zespół i współpracowników.', 'graphicDesigner': 'Projektant graficzny'},
    'vi': {'collaborators': 'Cộng tác viên', 'collaboratorsSubtitle': 'Gặp gỡ đội ngũ và những người đóng góp của chúng tôi.', 'graphicDesigner': 'Thiết kế đồ họa'}
}

for lang, trans in translations.items():
    pattern = r'(?m)(^\s+' + lang + r':\s*\{)(.*?)(^\s+\},?)'
    
    def repl(m):
        block = m.group(2)
        # Remove existing keys if any
        block = re.sub(r'(?m)^\s*\"(?:collaborators|collaboratorsSubtitle|graphicDesigner)\":\s*\".*?\",?\n?', '', block)
        
        # Build additions
        additions = ''
        for k, v in trans.items():
            additions += f'    "{k}": "{v}",\n'
        
        return m.group(1) + '\n' + additions + block + m.group(3)
        
    content = re.sub(pattern, repl, content, flags=re.DOTALL)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Done!')
