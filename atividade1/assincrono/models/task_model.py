from pydantic import BaseModel

class Task(BaseModel):
    title: str
    content: str
