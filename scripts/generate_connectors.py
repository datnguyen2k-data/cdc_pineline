#!/usr/bin/env python3
"""
Script để generate các file connector JSON từ template và .env
"""
import os
import json
import re
from pathlib import Path
from dotenv import load_dotenv


def load_env_vars():
    """Load biến môi trường từ file .env"""
    env_path = Path(__file__).parent.parent / ".env"
    if not env_path.exists():
        raise FileNotFoundError(f"File .env không tồn tại tại {env_path}")
    load_dotenv(env_path)
    return os.environ


def substitute_template(template_content: str, env_vars: dict) -> str:
    """Thay thế các placeholder trong template bằng giá trị từ env"""
    def replace_var(match):
        var_name = match.group(1)
        return env_vars.get(var_name, match.group(0))
    
    # Thay thế ${VAR_NAME} bằng giá trị từ env
    pattern = r'\$\{([A-Z_]+)\}'
    result = re.sub(pattern, replace_var, template_content)
    return result


def generate_connector(template_path: Path, output_path: Path, env_vars: dict):
    """Generate file connector từ template"""
    print(f"Đang generate: {output_path}")
    
    # Đọc template
    with open(template_path, 'r', encoding='utf-8') as f:
        template_content = f.read()
    
    # Thay thế biến môi trường
    content = substitute_template(template_content, env_vars)
    
    # Parse và format JSON để đảm bảo format đúng
    try:
        json_data = json.loads(content)
        formatted_content = json.dumps(json_data, indent=4, ensure_ascii=False)
    except json.JSONDecodeError as e:
        print(f"Lỗi khi parse JSON: {e}")
        raise
    
    # Ghi file output
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(formatted_content)
    
    print(f"✓ Đã tạo file: {output_path}")


def main():
    """Main function"""
    base_dir = Path(__file__).parent.parent
    src_dir = base_dir / "src"
    
    # Load biến môi trường
    env_vars = load_env_vars()
    
    # Tìm tất cả các file template
    template_files = list(src_dir.rglob("*.json.template"))
    
    if not template_files:
        print("Không tìm thấy file template nào (*.json.template)")
        return
    
    # Generate các file connector
    for template_path in template_files:
        # Tạo output path (bỏ .template)
        output_path = template_path.with_suffix('')
        generate_connector(template_path, output_path, env_vars)
    
    print("\n✓ Hoàn thành generate tất cả connectors!")


if __name__ == "__main__":
    main()

