import argparse
from pathlib import Path
from lxml import etree

def validate_xml(file_path):
    try:
        parser = etree.XMLParser(
            resolve_entities=False,
            no_network=True,
            dtd_validation=False,
            load_dtd=False
        )
        etree.parse(file_path, parser)
        return True, None
    except etree.XMLSyntaxError as e:
        return False, f"XML Syntax Error: {e}"
    except IOError as e:
        return False, f"File IO Error: {e}"
    except Exception as e:
        return False, f"Unexpected Error: {e}"

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'directory',
        type=str,
    )
    args = parser.parse_args()
    root_dir = Path(args.directory)
    if not root_dir.is_dir():
        print(f"Error: '{root_dir}' is not a valid directory")
        return
    xml_patterns = ['**/*.xhtml', '**/*.xml']
    xml_files = []
    for pattern in xml_patterns:
        xml_files.extend(root_dir.glob(pattern))
    error_count = 0
    for file_path in xml_files:
        if file_path.is_file():
            is_valid, error = validate_xml(file_path)
            if not is_valid:
                error_count += 1
                print(f"\nError in: {file_path.relative_to(root_dir)}")
                print(f"Details: {error}")
    print("\n" + "=" * 50)
    print(f"Scanned directory: {root_dir.resolve()}")
    print(f"Total files checked: {len(xml_files)}")
    print(f"Total errors found: {error_count}")
    print("Validation completed" + (" with errors" if error_count else " successfully"))

if __name__ == "__main__":
    main()
