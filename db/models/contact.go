package models

type Contact struct {
	UserID      uint   `gorm:"column:user_id"`
	ContactID   uint   `gorm:"column:contact_id"`
	ContactName string `gorm:"column:contact_name"`
}
