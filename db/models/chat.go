package models

import (
	"time"
)

type Chat struct {
	ID        uint64    `gorm:"column:id"`
	CreatedAt time.Time `gorm:"column:created_at"`
	IsDead    bool      `gorm:"column:is_dead;default:false"`
}
