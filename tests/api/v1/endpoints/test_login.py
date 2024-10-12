import pytest
from typing import Callable

from fastapi.testclient import TestClient

from app.core.config import settings


class TestLogin:
    def test_should_return_token_and_200(
        self, client: TestClient, user_with_pass: Callable
    ) -> None:
        user = user_with_pass("test_pass")
        data = {"username": user.email, "password": "test_pass"}
        response = client.post(
            f"{settings.API_V1_STR}/login/access-token",
            data=data,
        )
        data = response.json()

        assert response.status_code == 200
        assert "access_token" in data

    def test_should_return_forbidden_code(
        self, client: TestClient, user_with_pass: Callable
    ) -> None:
        user = user_with_pass("test_pass")
        data = {"username": user.email, "password": "test_pass2"}
        response = client.post(
            f"{settings.API_V1_STR}/login/access-token",
            data=data,
        )
        data = response.json()

        assert response.status_code == 403
        assert "access_token" not in data
