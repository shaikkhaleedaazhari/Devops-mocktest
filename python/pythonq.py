import json
import re
from datetime import datetime
from pathlib import Path

def extract_error_logs(log_path: str, output_path: str) -> None:
    error_data = []
    error_pattern = (
        r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3})'
        r' - ERROR - (.*?)(?=\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3}|\Z)'
    )
    
    try:
        log_path = Path(log_path)
        output_path = Path(output_path)
        
        # Read and process log file
        log_content = log_path.read_text()
        matches = re.findall(error_pattern, log_content, re.DOTALL)
        
        # Extract and store error data
        error_data = [
            {
                'timestamp': match[0],
                'error_message': match[1].strip(),
                'extracted_at': datetime.now().isoformat()
            }
            for match in matches
        ]
        
        # Write to JSON file
        output_path.write_text(json.dumps(error_data, indent=4))
        print(f"Successfully extracted {len(error_data)} error(s) to {output_path}")
        
    except FileNotFoundError:
        print(f"Error: Log file not found at {log_path}")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

if __name__ == '__main__':
    LOG_FILE = 'timestamp.log'
    OUTPUT_FILE = 'output.json'
    extract_error_logs(LOG_FILE, OUTPUT_FILE)
