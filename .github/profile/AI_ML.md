# 🤖 AI & Machine Learning Knowledge Base

## Table of Contents
1. [Fundamentals](#fundamentals)
2. [Machine Learning](#machine-learning)
3. [Deep Learning](#deep-learning)
4. [Natural Language Processing](#natural-language-processing)
5. [Computer Vision](#computer-vision)
6. [Large Language Models](#large-language-models)
7. [MLOps](#mlops)
8. [Projects & Applications](#projects--applications)

---

## Fundamentals

### Mathematics & Statistics

#### Linear Algebra
- Vectors, matrices, and tensor operations
- Eigenvalues and eigenvectors
- Matrix decomposition (SVD, QR)
- Applications in ML (PCA, embeddings)

#### Probability & Statistics
- Probability distributions (Normal, Poisson, Bernoulli)
- Bayesian inference
- Hypothesis testing
- Confidence intervals and p-values
- Correlation vs Causation

#### Calculus
- Derivatives and gradients
- Chain rule (backpropagation)
- Optimization (gradient descent variants)
- Convex and non-convex optimization

### Core ML Concepts

#### Supervised Learning
- **Classification**: Binary, multi-class, multi-label
- **Regression**: Linear, polynomial, non-linear
- **Training, Validation, Test splits**
- **Cross-validation strategies**
- **Overfitting and regularization**

#### Unsupervised Learning
- **Clustering**: K-means, Hierarchical, DBSCAN
- **Dimensionality Reduction**: PCA, t-SNE, UMAP
- **Anomaly Detection**: Isolation Forest, LOF

#### Semi-supervised Learning
- **Label propagation**
- **Self-training**
- **Co-training**

### Model Evaluation

#### Classification Metrics
- Accuracy, Precision, Recall, F1-score
- ROC-AUC curve
- Confusion matrix
- PR-AUC for imbalanced data

#### Regression Metrics
- MAE, MSE, RMSE
- R² score
- Mean Absolute Percentage Error (MAPE)

#### Validation Strategies
- Stratified k-fold cross-validation
- Time-series specific validation
- Holdout validation
- Nested cross-validation

---

## Machine Learning

### Scikit-learn Ecosystem

#### Supervised Learning

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

# Create pipeline
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('rf', RandomForestClassifier(n_estimators=100, max_depth=10))
])

# Train and predict
pipeline.fit(X_train, y_train)
y_pred = pipeline.predict(X_test)
```

#### Model Selection
```python
from sklearn.model_selection import GridSearchCV

param_grid = {
    'rf__n_estimators': [50, 100, 200],
    'rf__max_depth': [5, 10, 15],
    'rf__min_samples_split': [2, 5, 10]
}

grid_search = GridSearchCV(pipeline, param_grid, cv=5, n_jobs=-1)
grid_search.fit(X_train, y_train)
```

#### Feature Engineering
```python
from sklearn.preprocessing import PolynomialFeatures
from sklearn.feature_extraction.text import TfidfVectorizer

# Polynomial features
poly = PolynomialFeatures(degree=2)
X_poly = poly.fit_transform(X)

# Text features
vectorizer = TfidfVectorizer(max_features=1000, ngram_range=(1, 2))
X_tfidf = vectorizer.fit_transform(text_data)
```

### Ensemble Methods
- **Bagging**: Bootstrap Aggregating (Random Forest)
- **Boosting**: AdaBoost, Gradient Boosting, XGBoost, LightGBM
- **Stacking**: Multiple models combined
- **Voting**: Hard and soft voting classifiers

### Popular Libraries
- **Pandas**: Data manipulation and analysis
- **NumPy**: Numerical computations
- **Matplotlib & Seaborn**: Data visualization
- **Plotly**: Interactive visualizations

---

## Deep Learning

### Neural Network Fundamentals

#### Architecture Components
- **Input Layer**: Feature input
- **Hidden Layers**: Learned representations
- **Output Layer**: Predictions
- **Activation Functions**: ReLU, Sigmoid, Tanh, Softmax
- **Loss Functions**: MSE, Cross-entropy, Focal loss
- **Optimizers**: SGD, Adam, RMSprop, AdamW

#### Regularization Techniques
- **Dropout**: Random neuron deactivation
- **Batch Normalization**: Layer normalization
- **L1/L2 Regularization**: Weight penalties
- **Early Stopping**: Prevent overfitting
- **Data Augmentation**: Increase training data

### TensorFlow & Keras

#### Sequential Model
```python
from tensorflow import keras
from tensorflow.keras import layers

model = keras.Sequential([
    layers.Dense(128, activation='relu', input_shape=(784,)),
    layers.Dropout(0.2),
    layers.Dense(64, activation='relu'),
    layers.BatchNormalization(),
    layers.Dense(10, activation='softmax')
])

model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

model.fit(X_train, y_train, epochs=10, batch_size=32, validation_split=0.2)
```

#### Functional API
```python
inputs = keras.Input(shape=(784,))
x = layers.Dense(128, activation='relu')(inputs)
x = layers.Dropout(0.2)(x)
x = layers.Dense(64, activation='relu')(x)
outputs = layers.Dense(10, activation='softmax')(x)

model = keras.Model(inputs=inputs, outputs=outputs)
```

### PyTorch Framework

#### Custom Training Loop
```python
import torch
import torch.nn as nn

class CustomModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 128)
        self.fc2 = nn.Linear(128, 64)
        self.fc3 = nn.Linear(64, 10)
    
    def forward(self, x):
        x = torch.relu(self.fc1(x))
        x = torch.relu(self.fc2(x))
        return self.fc3(x)

model = CustomModel()
optimizer = torch.optim.Adam(model.parameters())
criterion = nn.CrossEntropyLoss()

for epoch in range(10):
    for batch in train_loader:
        x, y = batch
        optimizer.zero_grad()
        pred = model(x)
        loss = criterion(pred, y)
        loss.backward()
        optimizer.step()
```

### Specialized Architectures

#### Convolutional Neural Networks (CNNs)
- **Use cases**: Image classification, object detection, image segmentation
- **Components**: Convolutional layers, pooling, flattening
- **Popular architectures**: VGG, ResNet, Inception, MobileNet
- **Transfer learning**: Fine-tuning pre-trained models

#### Recurrent Neural Networks (RNNs)
- **Use cases**: Time series, sequence-to-sequence, language modeling
- **Variants**: LSTM, GRU
- **Attention mechanisms**: Self-attention, multi-head attention
- **Applications**: Machine translation, chatbots, sentiment analysis

#### Transformers
- **Architecture**: Encoder-decoder, self-attention
- **Pre-training**: BERT, GPT, T5
- **Applications**: NLP, vision transformers (ViT)
- **Fine-tuning strategies**: Task-specific adaptation

---

## Natural Language Processing

### Text Preprocessing

```python
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer

nltk.download('punkt')
nltk.download('stopwords')

text = "Hello, this is a sample text!"
tokens = word_tokenize(text.lower())
stop_words = set(stopwords.words('english'))
filtered = [word for word in tokens if word.isalnum() and word not in stop_words]
stemmer = PorterStemmer()
stemmed = [stemmer.stem(word) for word in filtered]
```

### Word Embeddings

#### Word2Vec
```python
from gensim.models import Word2Vec

# Train Word2Vec model
model = Word2Vec(sentences=corpus, vector_size=100, window=5, min_count=2, workers=4)

# Get word vector
vector = model.wv['hello']

# Find similar words
similar = model.wv.most_similar('hello', topn=5)
```

#### GloVe & FastText
- Pre-trained embeddings
- Transfer learning for new tasks
- Out-of-vocabulary handling (FastText)

### Transformers for NLP

#### Hugging Face Integration
```python
from transformers import AutoTokenizer, AutoModelForSequenceClassification
import torch

tokenizer = AutoTokenizer.from_pretrained('bert-base-uncased')
model = AutoModelForSequenceClassification.from_pretrained('bert-base-uncased')

text = "I love this movie!"
inputs = tokenizer(text, return_tensors="pt")
outputs = model(**inputs)
logits = outputs.logits
predictions = torch.argmax(logits, dim=1)
```

### NLP Applications

#### Sentiment Analysis
- Binary (positive/negative) or multi-class
- Aspect-based sentiment analysis
- Emotion detection

#### Named Entity Recognition (NER)
- Entity types: PERSON, LOCATION, ORGANIZATION, DATE
- Sequence labeling approaches (CRF, BiLSTM)

#### Machine Translation
- Sequence-to-sequence models
- Attention mechanisms
- Back-translation for data augmentation

#### Question Answering
- Extractive QA
- Generative QA
- RAG (Retrieval Augmented Generation)

---

## Computer Vision

### Image Classification

```python
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.preprocessing import image
import numpy as np

# Load pre-trained model
model = ResNet50(weights='imagenet')

# Load and preprocess image
img_path = 'image.jpg'
img = image.load_img(img_path, target_size=(224, 224))
x = image.img_to_array(img)
x = np.expand_dims(x, axis=0)
from tensorflow.keras.applications.resnet50 import preprocess_input
x = preprocess_input(x)

# Predict
predictions = model.predict(x)
from tensorflow.keras.applications.resnet50 import decode_predictions
results = decode_predictions(predictions, top=3)
```

### Object Detection
- **YOLOv8**: Real-time detection
- **Faster R-CNN**: Accurate but slower
- **SSD**: Single shot detector
- **EfficientDet**: Efficient and accurate

### Image Segmentation
- **Semantic Segmentation**: Pixel-level classification
- **Instance Segmentation**: Individual object detection
- **Panoptic Segmentation**: Combined semantic and instance
- **U-Net Architecture**: Popular for medical imaging

### Advanced Vision Tasks
- **Pose Estimation**: Skeleton detection
- **Face Recognition**: Identity verification
- **Depth Estimation**: 3D scene understanding
- **Super-resolution**: Image enhancement

---

## Large Language Models

### LLM Basics

#### Architecture
- **Transformer-based**: Encoder-decoder architecture
- **Parameters**: Billions of weights
- **Training**: Unsupervised learning on massive text corpora
- **Fine-tuning**: Task-specific adaptation

#### Popular Models
- **OpenAI**: GPT-4, GPT-3.5, GPT-3
- **Google**: PaLM, Bard, Gemini
- **Meta**: LLaMA, LLaMA 2
- **Anthropic**: Claude
- **Open-source**: Mistral, Llama, Falcon

### Prompt Engineering

#### Few-shot Prompting
```
Prompt: Translate English to French:
English: Hello
French: Bonjour
English: Good morning
French: Bon matin
English: How are you?
French:
```

#### Chain-of-Thought
```
Prompt: What is 15% of 200?
Let me break this down:
1. 15% means 15/100
2. 15/100 of 200 = (15/100) * 200
3. = 15 * 2 = 30
Answer: 30
```

### RAG (Retrieval Augmented Generation)

```python
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Chroma
from langchain.chat_models import ChatOpenAI
from langchain.chains import RetrievalQA

# Create vector store
embeddings = OpenAIEmbeddings()
vectorstore = Chroma.from_documents(documents, embeddings)

# Create QA chain
llm = ChatOpenAI(temperature=0)
qa = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vectorstore.as_retriever()
)

# Query
result = qa.run("What is the document about?")
```

### Fine-tuning & Adaptation
- **Instruction tuning**: Task-specific examples
- **LORA**: Low-rank adaptation for efficiency
- **QLoRA**: Quantized LORA
- **Adapter modules**: Lightweight fine-tuning

---

## MLOps

### Experiment Tracking

#### MLflow
```python
import mlflow

mlflow.start_run()
mlflow.log_param("lr", 0.001)
mlflow.log_param("epochs", 10)

# Train model
model = train_model(lr=0.001, epochs=10)

mlflow.log_metric("accuracy", 0.95)
mlflow.log_artifact("model.pkl")
mlflow.end_run()
```

#### Weights & Biases
```python
import wandb

wandb.init(project="my-project")
wandb.config.update({"lr": 0.001, "epochs": 10})

# Training loop
for epoch in range(10):
    loss = train_step()
    wandb.log({"loss": loss})

wandb.finish()
```

### Model Deployment
- **Containerization**: Docker for consistency
- **APIs**: FastAPI, Flask for model serving
- **Scalability**: Kubernetes for orchestration
- **Monitoring**: Performance tracking and drift detection

### Model Monitoring
- **Data drift detection**: Input distribution changes
- **Model drift detection**: Performance degradation
- **Explainability**: SHAP, LIME for interpretability
- **Feedback loops**: Continuous improvement

---

## Projects & Applications

### Recommendation Systems
- Collaborative filtering (user-item matrix factorization)
- Content-based filtering
- Hybrid approaches
- Deep learning for embeddings

### Fraud Detection
- Anomaly detection algorithms
- Real-time scoring
- Imbalanced data handling
- Feature importance analysis

### Time Series Forecasting
- ARIMA, Prophet models
- LSTM and Transformer architectures
- Multivariate forecasting
- Uncertainty quantification

### Chatbots & Conversational AI
- Intent recognition
- Entity extraction
- Dialogue management
- LLM-based approaches

---

## 📚 Resources & References

- [Scikit-learn Documentation](https://scikit-learn.org/)
- [TensorFlow & Keras](https://tensorflow.org/)
- [PyTorch Documentation](https://pytorch.org/)
- [Hugging Face Models](https://huggingface.co/models)
- [Papers with Code](https://paperswithcode.com/)
- [Kaggle Competitions](https://kaggle.com/)
