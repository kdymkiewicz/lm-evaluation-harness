#!/bin/bash

MODELS=(
    "meta-llama/Llama-3.2-1B-Instruct"
    "meta-llama/Llama-3.2-3B-Instruct"
    "meta-llama/Llama-3.1-8B-Instruct"
    "Qwen/Qwen2.5-0.5B-Instruct"
    "Qwen/Qwen2.5-1.5B-Instruct"
    "Qwen/Qwen2.5-3B-Instruct"
    "Qwen/Qwen2.5-7B-Instruct"
    "Qwen/Qwen2.5-14B-Instruct"
    "mistralai/Mistral-Nemo-Instruct-2407"
    "deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
    "deepseek-ai/DeepSeek-R1-Distill-Qwen-7B"
    "deepseek-ai/DeepSeek-R1-Distill-Llama-8B"
    "deepseek-ai/DeepSeek-R1-Distill-Qwen-14B"
)

# TRUTHFUL_QA
#TRUTHFUL_QA_LANGS=(
#    ar bn ca da de es eu fr gu hi hr hu hy id it
#    kn ml mr ne nl pt ro ru sk sr sv ta te uk vi zh
#)
#
#TASKS=""
#for LANG in "${TRUTHFUL_QA_LANGS[@]}"; do
#    TASKS="${TASKS}truthfulqa_${LANG}_mc1,truthfulqa_${LANG}_mc2,"
#done
#TASKS=${TASKS%,}  # Remove trailing comma
#
## Append English truthfulqa
#TASKS="${TASKS},truthfulqa_mc1,truthfulqa_mc2"
#
#for MODEL in "${MODELS[@]}"; do
#    CLEAN_MODEL_NAME=$(echo "$MODEL" | sed 's#[/\\#?%:]#_#g')
#    echo "Evaluating model: $MODEL on TruthfulQA"
#    accelerate launch -m lm_eval \
#        --model hf \
#        --model_args pretrained=$MODEL,parallelize=True,load_in_8bit=True \
#        --tasks $TASKS \
#        --wandb_args project=truthfulqa_${CLEAN_MODEL_NAME}
#done

# GLOBAL_MMLU
GLOBAL_MMLU_LANGS=(
am ar bn cs de el en fil fr ha he hi ig id it ja ky ko lt mg ms ne nl ny fa pl pt ro ru si sn so sr sw sv te tr uk vi yo zh
)

TASKS=""
for LANG in "${GLOBAL_MMLU_LANGS[@]}"; do
    TASKS="${TASKS}global_mmlu_full_${LANG},"
done
TASKS=${TASKS%,}

for MODEL in "${MODELS[@]}"; do
    CLEAN_MODEL_NAME=$(echo "$MODEL" | sed 's#[/\\#?%:]#_#g')
    echo "Evaluating model: $MODEL on GlobalMMLU"
    accelerate launch -m lm_eval \
        --model hf \
        --model_args pretrained=$MODEL,parallelize=True,load_in_8bit=True \
        --tasks $TASKS \
        --output_path global_mmlu_results/${MODEL} \
        --wandb_args project=global_mmlu_${CLEAN_MODEL_NAME}
done
