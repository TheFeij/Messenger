package models

type Contact struct {
	UserID      uint64 `gorm:"column:user_id"`
	ContactID   uint64 `gorm:"column:contact_id"`
	ContactName string `gorm:"column:contact_name"`
}
