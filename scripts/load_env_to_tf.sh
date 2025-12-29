#!/bin/bash
# Script để load biến từ .env và tạo terraform.tfvars

ENV_FILE=".env"
TFVARS_FILE="terraform/terraform.tfvars"

if [ ! -f "$ENV_FILE" ]; then
    echo "File .env không tồn tại!"
    exit 1
fi

# Tạo terraform.tfvars từ .env
cat > "$TFVARS_FILE" << 'EOF'
# File này được generate tự động từ .env
# Không commit file này vào git
EOF

# Load và convert các biến từ .env
while IFS='=' read -r key value || [ -n "$key" ]; do
    # Bỏ qua comment và dòng trống
    [[ "$key" =~ ^#.*$ ]] && continue
    [[ -z "$key" ]] && continue
    
    # Remove quotes nếu có
    value=$(echo "$value" | sed -e 's/^"//' -e 's/"$//')
    
    # Convert sang terraform variable format
    case "$key" in
        CHANDO_SHOP_ID)
            echo "chando_shop_id = \"$value\"" >> "$TFVARS_FILE"
            ;;
        CHANDO_API_KEY)
            echo "chando_api_key = \"$value\"" >> "$TFVARS_FILE"
            ;;
        FACIALBAR_SHOP_ID)
            echo "facialbar_shop_id = \"$value\"" >> "$TFVARS_FILE"
            ;;
        FACIALBAR_API_KEY)
            echo "facialbar_api_key = \"$value\"" >> "$TFVARS_FILE"
            ;;
        LABHAIR_SHOP_ID)
            echo "labhair_shop_id = \"$value\"" >> "$TFVARS_FILE"
            ;;
        LABHAIR_API_KEY)
            echo "labhair_api_key = \"$value\"" >> "$TFVARS_FILE"
            ;;
        MENARD_SHOP_ID)
            echo "menard_shop_id = \"$value\"" >> "$TFVARS_FILE"
            ;;
        MENARD_API_KEY)
            echo "menard_api_key = \"$value\"" >> "$TFVARS_FILE"
            ;;
        YAMAN_SHOP_ID)
            echo "yaman_shop_id = \"$value\"" >> "$TFVARS_FILE"
            ;;
        YAMAN_API_KEY)
            echo "yaman_api_key = \"$value\"" >> "$TFVARS_FILE"
            ;;
    esac
done < "$ENV_FILE"

echo "✓ Đã tạo file $TFVARS_FILE từ .env"

