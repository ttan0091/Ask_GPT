import os
import json
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm import tqdm
from openai import OpenAI

class QueryLLMs:
    def __init__(self, api_key_file, template_file, vulnerability_type, system_message):
        self.script_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Set paths
        self.api_key_path = os.path.join(self.script_dir, api_key_file)
        self.vul_code_dir = os.path.join(self.script_dir, 'vul_code', vulnerability_type)
        self.result_dir = os.path.join(self.script_dir, 'results', vulnerability_type)
        self.template_path = os.path.join(self.script_dir, template_file)
        
        self.api_key = self._get_api_key()
        self.template_data = self._get_template_data()
        self.vulnerability_type = vulnerability_type
        self.system_message = system_message

    def _get_api_key(self):
        try:
            with open(self.api_key_path, 'r') as file:
                return file.read().strip()
        except FileNotFoundError:
            print(f"API key file not found: {self.api_key_path}")
            return None

    def _get_template_data(self):
        try:
            with open(self.template_path, 'r', encoding='utf-8') as file:
                return json.load(file)
        except FileNotFoundError:
            print(f"Question template file not found: {self.template_path}")
            return None

    def _ask_chatgpt(self, question):
        client = OpenAI(api_key=self.api_key, base_url="https://api.deepseek.com")

        try:
            response = client.chat.completions.create(
                model="deepseek-chat",
                messages=[
                    {"role": "system", "content": self.system_message},
                    {"role": "user", "content": question}
                ],
                stream=False,
                timeout=120
            )
            return response
        except Exception as e:
            print(f"API request error: {str(e)}")
            return None

    def process_file(self, filename):
        # print(f"Start processing file: {filename}")
        file_path = os.path.join(self.vul_code_dir, filename)
        
        with open(file_path, 'r', encoding='utf-8') as file:
            code = file.read()
            result = {
                "filename": filename,
                "vulnerabilityType": self.template_data['vulnerabilityType'],
                "results": []
            }
            
            for prompt_type, prompts in self.template_data['prompts'].items():
                for prompt in prompts:
                    # print(f"  Processing {filename} - {prompt_type} - {prompt['id']}")
                    question = f"{prompt['content']}\n\nYour answer should be only yes or no.Nothing else.\n\nCode for you to process:\n\n{code}"
                    response = self._ask_chatgpt(question)
                    
                    if response is None:
                        print(f"  Error processing {filename} - {prompt_type} - {prompt['id']}: API request failed")
                        result["results"].append(f"Error processing {filename}: API request failed.")
                        continue

                    try:
                        reply = response.choices[0].message.content
                        result["results"].append({
                            "prompt_type": prompt_type,
                            "prompt_id": prompt['id'],
                            "prompt_content": prompt['content'],
                            "response": reply
                        })
                        # print(f"  Successfully processed {filename} - {prompt_type} - {prompt['id']}")
                    except KeyError:
                        print(f"Error processing {filename} - {prompt_type} - {prompt['id']}: 'choices' not found in response")
                        print(f"Response content: {json.dumps(response, indent=2)}")
                        result["results"].append(f"Error processing {filename}")

        print(f"File {filename} processing completed")
        return result

    def process_specific_file(self):
        template_data = self._get_template_data()
        prompts = [prompt for prompt in template_data['prompts']['roleOriented'] if 1 <= prompt['id'] <= 20]
        if not prompts:
            print("No specified prompt content found")
            return

        sol_files = [f for f in os.listdir(self.vul_code_dir) if f.endswith(".sol")]
        print(f"Found {len(sol_files)} .sol files to process")

        all_results = {}

        for filename in tqdm(sol_files, desc="Processing files"):
            file_path = os.path.join(self.vul_code_dir, filename)
            
            with open(file_path, 'r', encoding='utf-8') as file:
                code = file.read()

            def process_single_query(prompt, repeat):
                question = f"{prompt['id']}.{prompt['content']}\n\nYour answer should be only yes or no.Nothing else.\n\nCode for you to process:\n\n{code}"
                response = self._ask_chatgpt(question)
                
                if response is None:
                    print(f"API request failed: file {filename}, prompt {prompt['id']}, repeat {repeat}")
                    return None

                try:
                    reply = response.choices[0].message.content
                    return {
                        "prompt_id": prompt['id'],
                        "prompt_content": prompt['content'],
                        "repeat": repeat,
                        "response": reply
                    }
                except KeyError:
                    print(f"Error processing response: file {filename}, prompt {prompt['id']}, repeat {repeat}")
                    return None

            file_results = []
            with ThreadPoolExecutor(max_workers=1000) as executor:
                futures = [executor.submit(process_single_query, prompt, repeat) 
                           for prompt in prompts 
                           for repeat in range(1, 21)]
                
                for future in as_completed(futures):
                    result = future.result()
                    if result:
                        file_results.append(result)

            all_results[filename] = file_results

        # Ensure result directory exists
        os.makedirs(self.result_dir, exist_ok=True)

        # Write results to JSON file
        result_filename = "all_files_results.json"
        result_file_path = os.path.join(self.result_dir, result_filename)
        with open(result_file_path, 'w', encoding='utf-8') as result_file:
            json.dump(all_results, result_file, ensure_ascii=False, indent=2)

        print(f"Processing completed, results saved in {result_file_path}.")

# Example usage:
# processor = QueryLLMs('api_key_deepseek.txt', 'question_template.json', 'vul_1_Approval Not Cleared', "")
# processor.process_all_files()
# processor = QueryLLMs('api_key_deepseek.txt', 'question_template_Reentrancy.json', 'vul_13_Reentrancy', "")
# processor.process_all_files()
# processor = QueryLLMs('api_key_deepseek.txt', 'question_template_Timestamp.json', 'vul_14_Timestamp_Dependency', "")
# processor.process_all_files()
processor = QueryLLMs('api_key_deepseek.txt', 'question_template_Approval.json', 'vul_1_Approval Not Cleared', "")
processor.process_specific_file()